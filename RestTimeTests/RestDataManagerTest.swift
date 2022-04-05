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
        let record = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                startDate: "2020-12-30 10:00:00".toDate(),
                                endDate: "2020-12-30 11:00:00".toDate())
        
        RestDataManager.saveRestRecord(restRecord: record)
        let obtainedRecords = RestDataManager.getRestRecords()
        
        XCTAssertTrue(isEqualWithoutCheckingId([record], obtainedRecords))
    }
    
    func testShouldGetEmptyArrayWhenNotSavedBefore() {
        let obtainedRecords = RestDataManager.getRestRecords()
        
        XCTAssertEqual(obtainedRecords, [])
    }
    
    func testGetRecordsAtDay() {
        let record1 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        let record2 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 12:00:00".toDate(),
                                 endDate: "2020-12-30 13:00:00".toDate())
        let record3 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2021-12-30 12:00:00".toDate(),
                                 endDate: "2021-12-30 13:00:00".toDate())
        RestDataManager.saveRestRecord(restRecord: record1)
        RestDataManager.saveRestRecord(restRecord: record2)
        RestDataManager.saveRestRecord(restRecord: record3)
        
        let records = RestDataManager.getRestRecordAtDay(date: "2020-12-30 00:00:00".toDate())
        
        XCTAssertTrue(isEqualWithoutCheckingId(records, [record2, record1]))
    }
    
    private func isEqualWithoutCheckingId(_ records1: [RestRecord], _ records2: [RestRecord]) -> Bool {
        let records1WithoutId = records1.map { toRestRecordWithoutId(restRecord: $0) }
        let records2WithoutId = records2.map { toRestRecordWithoutId(restRecord: $0) }
        return records1WithoutId == records2WithoutId
    }
    
    private func toRestRecordWithoutId(restRecord: RestRecord) -> RestRecord {
        return RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                          startDate: restRecord.startDate,
                          endDate: restRecord.endDate)
    }
    
    private func containsWithoutCheckingId(record: RestRecord, records: [RestRecord]) -> Bool {
        for r in records {
            if r.startDate == record.startDate && r.endDate == record.endDate {
                return true
            }
        }
        return false
    }
    
}
