//
//  Alamofire_PrephirencesTests.swift
//  Alamofire-PrephirencesTests
//
//  Created by phimage on 15/10/15.
//  Copyright © 2015 phimage. All rights reserved.
//

import XCTest
@testable import AlamofirePrephirences

import Alamofire
import Prephirences

class Alamofire_PrephirencesTests: XCTestCase {
    let defaultTimeout: NSTimeInterval = 10
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadPropertyListFromURL() {
        let pref : MutableDictionaryPreferences = [:]

        let expectation = expectationWithDescription("request should succeed")
        
        var response : Response<AnyObject, NSError>? = nil
        pref.loadPropertyListFromURL("https://raw.githubusercontent.com/phimage/Prephirences/master/PrephirencesiOS/Info.plist",
            completionHandler: { closureResponse in
                response = closureResponse
                expectation.fulfill()
        })
        
        pref.loadPropertyListFromURL("https://raw.githubusercontent.com/phimage/Prephirences/master/PrephirencesiOS/Info.plist")
        
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)

        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertNotNil(response.data, "data should not be nil")
            
            switch response.result {
            case .Success:
                print("\(pref.dictionary())")
                break
            case .Failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        } else {
            XCTFail("response should not be nil")
        }
    }
    
    
    func testLoadJSONFromURL() {
        let pref : MutableDictionaryPreferences = [:]
        
        let expectation = expectationWithDescription("request should succeed")
        
        var response : Response<AnyObject, NSError>? = nil
        pref.loadJSONFromURL("https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/Prephirences/2.0.0/Prephirences.podspec.json",
            completionHandler: { closureResponse in
                response = closureResponse
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
        
        if let response = response {
            XCTAssertNotNil(response.request, "request should not be nil")
            XCTAssertNotNil(response.response, "response should not be nil")
            XCTAssertNotNil(response.data, "data should not be nil")
            
            switch response.result {
            case .Success:
                print("\(pref.dictionary())")
                break
            case .Failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        } else {
            XCTFail("response should not be nil")
        }
    }
    
    
}
 