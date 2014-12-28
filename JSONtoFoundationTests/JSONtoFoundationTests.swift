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
    
    func testSwiftJSONConversion() {
        let jsonString = "{\"id\":\"file\",\"value\": \"File\",\"menuitem\": []}"
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSErrorPointer = NSErrorPointer()
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: convertError) as NSDictionary
        
        let jsonConversion = JSONConverter.createPropertiesForFileType(jsonFoundation, type: .Swift)
        
        XCTAssertEqual(jsonConversion, "var id: String?\nvar menuitem: [AnyObject]?\nvar value: String?\n", "Swift JSON conversion failed")
    }
    
    func testObjCJSONConversion() {
        let jsonString = "{\"id\":\"file\",\"value\": \"File\",\"menuitem\": []}"
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSErrorPointer = NSErrorPointer()
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: convertError) as NSDictionary
        
        let jsonConversion = JSONConverter.createPropertiesForFileType(jsonFoundation, type: .ObjectiveC)
        
        XCTAssertEqual(jsonConversion, "@property (nonatomic)NSString *id;\n@property (nonatomic)NSArray *menuitem;\n@property (nonatomic)NSString *value;\n", "Objective-C JSON conversion failed")
    }
    
}
