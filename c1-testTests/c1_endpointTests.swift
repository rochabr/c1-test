//
//  c1_test.swift
//  c1_test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import XCTest
@testable import c1_test

class c1_endpointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndpointCreation() {
        // This is an example of a functional test case.
        XCTAssertTrue(Endpoint.Global.url() == "https://alpha-api.app.net/stream/0/posts/stream/global")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
