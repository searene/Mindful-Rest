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
    
    func testGetShortDescriptionForSeconds() {
        let duration = Duration(durationInSeconds: 30)
        
        let shortDesc = duration.getShortDescription()
        
        XCTAssertEqual(shortDesc, "30s")
    }
    
    func testGetShortDescriptionForMinutes() {
        let duration = Duration(durationInSeconds: 150)
        
        let shortDesc = duration.getShortDescription()
        
        XCTAssertEqual(shortDesc, "2m")
    }

}
