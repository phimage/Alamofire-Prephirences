//
//  SerializationFormat.swift
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
import Alamofire

public enum SerializationFormat {
    case propertyList(PropertyListSerialization.ReadOptions)
    case json(JSONSerialization.ReadingOptions)
    case custom(DataResponseSerializer<Any>)

    func failureReason(error: Error) -> AFError.ResponseSerializationFailureReason {
        switch self {
        case .propertyList: return .propertyListSerializationFailed(error: error)
        case .json: return .jsonSerializationFailed(error: error)
        case .custom: return .jsonSerializationFailed(error: error)
        }
    }

    var responseSerializer: DataResponseSerializer<Any> {
        switch self {
        case .propertyList(let options): return DataRequest.propertyListResponseSerializer(options: options)
        case .json(let options): return DataRequest.jsonResponseSerializer(options: options)
        case .custom(let responseSerializer): return responseSerializer
        }
    }
}
