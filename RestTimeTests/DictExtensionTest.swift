//
//  DictExtensionTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import Mindful_Rest

class DictExtensionTest: XCTestCase {

    func testToJSONString() {
        let dict = ["a": "b", "c": "d"]
        
        let jsonString = dict.toJSONString()
        let convertedDict = jsonString.toDict()
        
        XCTAssertEqual(convertedDict.count, 2)
        XCTAssertEqual(convertedDict["a"] as! String, "b")
        XCTAssertEqual(convertedDict["c"] as! String, "d")
    }
}
