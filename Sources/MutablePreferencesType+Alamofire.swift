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

public enum AFPPRError: Error {
    case notConvertibleToDictionary
}

public extension MutablePreferencesType {
    
    @discardableResult
    public func loadPropertyList(from url: URLConvertible, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> Request {
        return load(from: url, format: .propertyList([]), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func loadJSON(from url: URLConvertible, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        return load(from: url, format: .json(.allowFragments), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func loadPropertyList(from urlRequest: URLRequestConvertible, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        return load(from: urlRequest, format: .propertyList([]), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func loadJSON(from urlRequest: URLRequestConvertible, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        return load(from: urlRequest, format: .json(.allowFragments), completionHandler: completionHandler)
    }

    // MARK: with format
    @discardableResult
    public func load(from url: URLConvertible, format: SerializationFormat, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        return response(to: Alamofire.request(url, method: .get), format: format, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func load(from urlRequest: URLRequestConvertible, format: SerializationFormat, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        return response(to: Alamofire.request(urlRequest), format: format, completionHandler: completionHandler)
    }

    // MARK: response
    fileprivate func response(to request: DataRequest, format: SerializationFormat, completionHandler: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest  {
        request.validate() // XXX could add here accepted content type
        // XXX if no format defined, could get returned content-type from responseContentType = response.MIMEType, responseMIMEType = MIMEType(responseContentType)
        let responseSerializer = format.responseSerializer
        return request.response(responseSerializer: responseSerializer){
            response in
            switch response.result {
            case .success(let object):
                guard let dico = object as? [String : Any] else {
                    let error = AFError.responseSerializationFailed(reason:  format.failureReason(error: AFPPRError.notConvertibleToDictionary))
                    let failureResponse = DataResponse<Any>(request: response.request,
                        response: response.response,
                        data: response.data,
                        result: .failure(error))
                    
                    completionHandler?(failureResponse)
                    break
                }
                self.set(dictionary: dico)
                completionHandler?(response)
            case .failure:
                completionHandler?(response)
            }
        }
    }
}
