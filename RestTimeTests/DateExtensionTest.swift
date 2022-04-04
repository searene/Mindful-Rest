//
//  DateExtensionTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import RestTime

class DateExtensionTest: XCTestCase {

    func testGetDurationStr() {
        
        let durationStr = "2020-03-10 10:00:00".toDate()
            .getDurationString(endDate: "2020-03-10 10:30:00".toDate())
        
        XCTAssertEqual(durationStr, "30:00")
    }
}
