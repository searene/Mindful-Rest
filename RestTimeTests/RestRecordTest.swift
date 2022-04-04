//
//  RestRecord.swift
//  RestTimeTests
//
//  Created by Joey Green on 2022/4/4.
//

import XCTest
@testable import RestTime

class RestRecordTest: XCTestCase {

    func testToDict() {
        let startDateStr: String = "2020-03-10 12:00:00"
        let endDateStr: String = "2020-03-10 13:00:00"
        let restRecord = RestRecord(startDate: startDateStr.toDate(), endDate: endDateStr.toDate())
        
        let restRecordDict = restRecord.toDict()
        
        let expect: [String: String] = ["startDate": startDateStr, "endDate": endDateStr]
        XCTAssertEqual(restRecordDict, expect)
    }
    
    func testToDicts() {
        let startDateStr: String = "2020-03-10 12:00:00"
        let endDateStr: String = "2020-03-10 13:00:00"
        let restRecord = RestRecord(startDate: startDateStr.toDate(), endDate: endDateStr.toDate())
        
        let restRecordDicts = RestRecord.toDicts(restRecords: [restRecord])
        
        let expect: [[String: String]] = [["startDate": startDateStr, "endDate": endDateStr]]
        XCTAssertEqual(restRecordDicts, expect)
    }
    
    func testFromDicts() {
        let startDateStr1: String = "2020-03-10 12:00:00"
        let endDateStr1: String = "2020-03-10 13:00:00"
        let restRecord1 = RestRecord(startDate: startDateStr1.toDate(), endDate: endDateStr1.toDate())
        let startDateStr2: String = "2020-04-10 12:00:00"
        let endDateStr2: String = "2020-04-10 13:00:00"
        let restRecord2 = RestRecord(startDate: startDateStr2.toDate(), endDate: endDateStr2.toDate())
        
        let restRecords = RestRecord.fromDicts(dicts: [["startDate": startDateStr1, "endDate": endDateStr1],
                                    ["startDate": startDateStr2, "endDate": endDateStr2]])
        
        XCTAssertEqual(restRecords, [restRecord1, restRecord2])
    }
    
}
