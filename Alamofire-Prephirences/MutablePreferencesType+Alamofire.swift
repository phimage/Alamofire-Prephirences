//
//  Prephirences+Alamofire.swift
//  Alamofire-Prephirences
//
//  Created by phimage on 15/10/15.
//  Copyright © 2015 phimage. All rights reserved.
//

import Foundation
import Prephirences
import Alamofire

public extension MutablePreferencesType {

    public func loadPropertyListFromURL(url: URLStringConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return Alamofire.request(.GET, url)
            .validate()
            .responsePropertyList { response in
                switch response.result {
                case .Success(let plist):
                    guard let dico = plist as? [String : AnyObject] else {
                        let error = Error.errorWithCode(.PropertyListSerializationFailed, failureReason: "Unable to convert plist to dictionnary")
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

    public func loadJSONFromURL(url: URLStringConvertible, completionHandler: (Response<AnyObject, NSError> -> Void)? = nil) -> Request {
        return Alamofire.request(.GET, url)
            .validate()
            .responseJSON{ response in
                switch response.result {
                case .Success(let plist):
                    guard let dico = plist as? [String : AnyObject] else {
                        let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: "Unable to convert JSON to dictionnary")
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