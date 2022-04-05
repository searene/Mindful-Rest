//
//  RestDataManagerTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import RestTime

class RestDataManagerTest: XCTestCase {
    
    override func setUp() {
        RestDataManager.resetDB()
    }
    
    func testSaveAndGetRecords() {
        let record = RestRecord(startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        
        RestDataManager.saveRestRecord(restRecord: record)
        let obtainedRecords = RestDataManager.getRestRecords()
        
        XCTAssertEqual([record], obtainedRecords)
    }
    
    func testShouldGetEmptyArrayWhenNotSavedBefore() {
        let obtainedRecords = RestDataManager.getRestRecords()
        
        XCTAssertEqual(obtainedRecords, [])
    }
    
    func testGetRecordsAtDay() {
        let record1 = RestRecord(startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        let record2 = RestRecord(startDate: "2020-12-30 12:00:00".toDate(),
                                 endDate: "2020-12-30 13:00:00".toDate())
        let record3 = RestRecord(startDate: "2021-12-30 12:00:00".toDate(),
                                 endDate: "2021-12-30 13:00:00".toDate())
        RestDataManager.saveRestRecord(restRecord: record1)
        RestDataManager.saveRestRecord(restRecord: record2)
        RestDataManager.saveRestRecord(restRecord: record3)
        
        let records = RestDataManager.getRestRecordAtDay(date: "2020-12-30 00:00:00".toDate())
        
        XCTAssertEqual(records, [record2, record1])
    }
    
}
