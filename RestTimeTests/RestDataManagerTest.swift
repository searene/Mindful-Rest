//
//  RestDataManagerTest.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import Mindful_Rest

class RestDataManagerTest: XCTestCase {
    
    override func setUp() {
        RestDataManager.resetDB()
    }
    
    func testDeleteRestRecord() {
        let record1 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        let record2 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 12:00:00".toDate(),
                                 endDate: "2020-12-30 13:00:00".toDate())
        let recordId1 = RestDataManager.saveRestRecord(restRecord: record1)
        let recordId2 = RestDataManager.saveRestRecord(restRecord: record2)
        
        RestDataManager.deleteRestRecordById(restRecordId: recordId1)
        
        let records = RestDataManager.getRestRecords()
        XCTAssertEqual(records, [RestRecord(id: recordId2, startDate: "2020-12-30 12:00:00".toDate(), endDate: "2020-12-30 13:00:00".toDate())])
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
        
        XCTAssertTrue(isEqualWithoutCheckingId(records, [record1, record2]))
    }
    
    func testUpdateRecordById() {
        let record1 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        let record2 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 12:00:00".toDate(),
                                 endDate: "2020-12-30 13:00:00".toDate())
        let recordId1 = RestDataManager.saveRestRecord(restRecord: record1)
        let recordId2 = RestDataManager.saveRestRecord(restRecord: record2)

        let updatedRecord = RestRecord(id: recordId1, startDate: "2022-12-30 10:00:00".toDate(), endDate: "2022-12-31 22:00:00".toDate())
        RestDataManager.updateRestRecordById(restRecord: updatedRecord)
        
        let records = RestDataManager.getRestRecords()
        XCTAssertTrue(isEqualWithoutCheckingId(records, [updatedRecord, record2]))
    }
    
    func testInsertOngoingRest() {
        let startDate = "2020-12-30 10:00:00".toDate()
        RestDataManager.upsertOngoingRest(startDate: startDate)
        
        let ongoingRest = RestDataManager.getOngoingRest()
        
        XCTAssertTrue(ongoingRest != nil)
        XCTAssertEqual(ongoingRest!.startDate, startDate)
    }
    
    func testUpdateOngoingRest() {
        RestDataManager.upsertOngoingRest(startDate: "2020-12-30 10:00:00".toDate())
        RestDataManager.upsertOngoingRest(startDate: "2020-12-31 10:00:00".toDate())
        
        let ongoingRest = RestDataManager.getOngoingRest()
        
        XCTAssertTrue(ongoingRest != nil)
        XCTAssertEqual(ongoingRest!.startDate, "2020-12-31 10:00:00".toDate())
    }
    
    func testGetNoOngoingRest() {
        let ongoingRest = RestDataManager.getOngoingRest()
        
        XCTAssertTrue(ongoingRest == nil)
    }
    
    /// When fetching RestRecords at a given day, if the resting starts from today and continues
    /// to tomorrow, let it ends at 23:59:59 today
    func testShouldEndAtTheEndOfTodayIfRecordContinuesToTomorrow() {
        let record = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-29 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        let recordId = RestDataManager.saveRestRecord(restRecord: record)
        
        let records = RestDataManager.getRestRecordAtDay(date: "2020-12-29 00:00:00".toDate())
        
        XCTAssertEqual(records, [RestRecord(id: recordId, startDate: "2020-12-29 10:00:00".toDate(), endDate: "2020-12-29 23:59:59".toDate())])
    }
    
    func testDeleteOngoingRest() {
        let record1 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-29 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        RestDataManager.saveRestRecord(restRecord: record1)
        RestDataManager.upsertOngoingRest(startDate: Date())
        
        RestDataManager.deleteOngoingRest()
        
        let ongoingRest = RestDataManager.getOngoingRest()
        XCTAssertNil(ongoingRest)
    }
    
    func testDeleteRestRecordsByStartDate(startDate: Date) {
        let record1 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-29 10:00:00".toDate(),
                                 endDate: "2020-12-29 11:00:00".toDate())
        let record2 = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                 startDate: "2020-12-30 10:00:00".toDate(),
                                 endDate: "2020-12-30 11:00:00".toDate())
        RestDataManager.saveRestRecord(restRecord: record1)
        RestDataManager.saveRestRecord(restRecord: record2)
        
        RestDataManager.deleteRestRecordsByStartDate(startDate: "2020-12-29 00:00:00".toDate())
        
        let records = RestDataManager.getRestRecords()
        XCTAssertEqual(records.count, 1)
        XCTAssertTrue(containsWithoutCheckingId(record: record2, records: records))
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
