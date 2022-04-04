//
//  StringExtensionTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import RestTime

class StringExtensionTest: XCTestCase {

    func testToDict() {
        let s = """
{"a": "b", "c": "d"}
"""
       
        let dict = s.toDict()
        
        XCTAssertEqual(dict.count, 2)
        XCTAssertEqual(dict["a"] as! String, "b")
        XCTAssertEqual(dict["c"] as! String, "d")
    }

}
