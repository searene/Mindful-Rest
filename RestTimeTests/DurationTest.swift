//
//  DurationTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/5.
//

import XCTest
@testable import Mindful_Rest

class DurationTest: XCTestCase {
    
    func testGetDurationStringWithSeconds() {
        let duration = Duration(durationInSeconds: 30)
        
        let durationString = duration.getFullDescription()
        
        XCTAssertEqual(durationString, "30s")
    }

    func testGetDurationStringWithMinutes() {
        let duration = Duration(durationInSeconds: 100)
        
        let durationString = duration.getFullDescription()
        
        XCTAssertEqual(durationString, "1m 40s")
    }
    
    func testGetDurationStringWithHours() {
        let duration = Duration(durationInSeconds: 3710)
        
        let durationString = duration.getFullDescription()
        
        XCTAssertEqual(durationString, "1h 1m 50s")
    }
    
    func testAdd() {
        let d1 = Duration(durationInSeconds: 10)
        let d2 = Duration(durationInSeconds: 20)
        
        let d = d1 + d2
        
        XCTAssertEqual(d.durationInSeconds, 30)
    }
    
    func testGetFullDescriptionForHourAndMinute() {
        let duration = Duration(durationInSeconds: 3660)
        
        let fullDesc = duration.getFullDescription()
        
        XCTAssertEqual(fullDesc, "1h 1m")
    }
    
    func testGetFullDescriptionForHour() {
        let duration = Duration(durationInSeconds: 3600)
        
        let fullDesc = duration.getFullDescription()
        
        XCTAssertEqual(fullDesc, "1h")
    }
    
    func testGetFullDescriptionForMinute() {
        let duration = Duration(durationInSeconds: 180)
        
        let fullDesc = duration.getFullDescription()
        
        XCTAssertEqual(fullDesc, "3m")
    }

}
