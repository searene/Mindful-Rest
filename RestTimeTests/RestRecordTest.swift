//
//  RestRecord.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import RestTime

class RestRecordTest: XCTestCase {
    
    func testGetDuration() -> Void {
        let record = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                startDate: "2020-10-30 10:00:00".toDate(),
                                endDate: "2020-10-30 10:01:10".toDate())
        
        let duration = record.getDuration()
        
        XCTAssertEqual(duration, Duration(durationInSeconds: 70))
    }
    
    func testGetTotalDuration() -> Void {
        let record1 = RestRecord(id: 1,
                                startDate: "2020-10-30 10:00:00".toDate(),
                                endDate: "2020-10-30 10:01:10".toDate())
        
        let record2 = RestRecord(id: 2,
                                startDate: "2020-10-30 10:02:00".toDate(),
                                endDate: "2020-10-30 10:02:06".toDate())
        
        let duration = RestRecord.getTotalDuration([record1, record2])
        
        XCTAssertEqual(duration, Duration(durationInSeconds: 76))
    }

}
