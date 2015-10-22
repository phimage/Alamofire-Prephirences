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
    case PropertyList(NSPropertyListReadOptions), JSON(NSJSONReadingOptions), Custom(ResponseSerializer<AnyObject, NSError>)

    var errorCode: Error.Code {
        switch self {
        case PropertyList: return Error.Code.PropertyListSerializationFailed
        case JSON: return Error.Code.JSONSerializationFailed
        case Custom: return Error.Code.DataSerializationFailed
        }
    }

    var responseSerializer: ResponseSerializer<AnyObject, NSError> {
        switch self {
        case PropertyList(let options): return Request.propertyListResponseSerializer(options: options)
        case JSON(let options): return Request.JSONResponseSerializer(options: options)
        case Custom(let responseSerializer): return responseSerializer
        }
    }
}
