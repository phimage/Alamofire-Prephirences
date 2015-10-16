//
//  Prephirences+Alamofire.swift
//  Alamofire-Prephirences
/*
The MIT License (MIT)

Copyright (c) 2015 Eric Marchand (phimage)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


import Foundation
import Prephirences
import Alamofire

enum FileSerializationFormat {
    case PropertyList(NSPropertyListReadOptions), JSON(NSJSONReadingOptions)
    
    var errorCode: Error.Code {
        switch self {
        case PropertyList: return Error.Code.PropertyListSerializationFailed
        case JSON: return Error.Code.JSONSerializationFailed
        }
    }
    
    var responseSerializer: ResponseSerializer<AnyObject, NSError> {
        switch self {
        case PropertyList(let options): return Request.propertyListResponseSerializer(options: options)
        case JSON(let options): return Request.JSONResponseSerializer(options: options)
        }
    }
}

public extension MutablePreferencesType {

    public func loadPropertyListFromURL(url: URLStringConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return loadFromURL(url, format: .PropertyList(NSPropertyListReadOptions()), completionHandler: completionHandler)
    }

    public func loadJSONFromURL(url: URLStringConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return loadFromURL(url, format: .JSON(.AllowFragments), completionHandler: completionHandler)
    }
    
    public func loadPropertyListFromURLRequest(URLRequest: URLRequestConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return loadFromURLRequest(URLRequest, format: .PropertyList(NSPropertyListReadOptions()), completionHandler: completionHandler)
    }
    
    public func loadJSONFromURLRequest(URLRequest: URLRequestConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return loadFromURLRequest(URLRequest, format: .JSON(.AllowFragments), completionHandler: completionHandler)
    }

    // MARK: private load
    private func loadFromURL(url: URLStringConvertible, format: FileSerializationFormat, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return responseToRequest(Alamofire.request(.GET, url), format: format, completionHandler: completionHandler)
    }

    private func loadFromURLRequest(URLRequest: URLRequestConvertible, format: FileSerializationFormat, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return responseToRequest(Alamofire.request(URLRequest), format: format, completionHandler: completionHandler)
    }

    // MARK: response
    private func responseToRequest(request: Request, format: FileSerializationFormat, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request  {
        request.validate() // XXX could add here accepted content type
        // XXX if no format defined, could get returned content-type from responseContentType = response.MIMEType, responseMIMEType = MIMEType(responseContentType)

        return request.response(responseSerializer: format.responseSerializer){ response in
                switch response.result {
                case .Success(let object):
                    guard let dico = object as? [String : AnyObject] else {
                        let error = Error.errorWithCode(format.errorCode, failureReason: "Unable to convert to dictionnary")
                        let failureResponse = Response<AnyObject, NSError>(request: response.request,
                            response: response.response,
                            data: response.data,
                            result: .Failure(error))
                        
                        completionHandler?(failureResponse)
                        break
                    }
                    self.setObjectsForKeysWithDictionary(dico)
                    completionHandler?(response)
                case .Failure:
                    completionHandler?(response)
                }
        }
        
    }
 
}