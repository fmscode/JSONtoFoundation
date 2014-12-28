//
//  JSONtoFoundationTests.swift
//  JSONtoFoundationTests
//
//  Created by Frank Michael on 12/28/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa
import XCTest

class JSONtoFoundationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatItReplacesUnderscores() {
        
        let stringTestOne = "this_is_a_long_string"
        let replacedTestOne = stringTestOne.underscoreReplacement()
        
        XCTAssertEqual(replacedTestOne, "thisIsALongString", "Underscore Failed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
