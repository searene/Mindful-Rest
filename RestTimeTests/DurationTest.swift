//
//  DurationTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/5.
//

import XCTest
@testable import RestTime

class DurationTest: XCTestCase {
    
    func testGetDurationStringWithSeconds() {
        let duration = Duration(durationInSeconds: 30)
        
        let durationString = duration.toString()
        
        XCTAssertEqual(durationString, "30 seconds")
    }

    func testGetDurationStringWithMinutes() {
        let duration = Duration(durationInSeconds: 100)
        
        let durationString = duration.toString()
        
        XCTAssertEqual(durationString, "1 minute 40 seconds")
    }
    
    func testGetDurationStringWithHours() {
        let duration = Duration(durationInSeconds: 3710)
        
        let durationString = duration.toString()
        
        XCTAssertEqual(durationString, "1 hour 1 minute 50 seconds")
    }
    
    func testAdd() {
        let d1 = Duration(durationInSeconds: 10)
        let d2 = Duration(durationInSeconds: 20)
        
        let d = d1 + d2
        
        XCTAssertEqual(d.durationInSeconds, 30)
    }

}
