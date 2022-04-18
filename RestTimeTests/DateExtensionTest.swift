//
//  DateExtensionTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import Mindful_Rest

class DateExtensionTest: XCTestCase {

    func testGetDurationStr() {
        
        let durationStr = "2020-03-10 10:00:00".toDate()
            .getDurationString(endDate: "2020-03-10 10:30:00".toDate())
        
        XCTAssertEqual(durationStr, "30:00")
    }
    
    func testGetStartOfDay() {
        let date = "2020-03-10 10:00:00".toDate()
        
        let newDate = date.getStartOfDay()
        
        XCTAssertEqual(newDate, "2020-03-10 00:00:00".toDate())
    }
    
    func testGetEndOfDate() {
        
        let date = "2020-03-10 10:00:00".toDate()
        
        let newDate = date.getEndOfDay()
        
        XCTAssertEqual(newDate, "2020-03-10 23:59:59".toDate())
    }
}
