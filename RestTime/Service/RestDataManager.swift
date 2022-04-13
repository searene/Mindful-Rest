//
//  RestDataManager.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation
import SQLite

struct RestRecordDataScheme {
    let table: Table
    let id: Expression<Int64>
    let startDate: Expression<Date>
    let endDate: Expression<Date?>
    
    /// Check if the current RestRecord should belong
    /// to the given day when querying statistics
    func shouldBelongToDay(day: Date) -> Expression<Bool?> {
        let startOfDate = day.getStartOfDay()
        return startDate >= startOfDate
                && startDate < startOfDate.nextDay
                && endDate != nil
        
    }
}

struct RestDataManager {
    
    private static let fileManager = getFileManager()
    private static let dbFileUrl = getDataFilePath(fileManager: fileManager)
    private static var db = try! Connection(dbFileUrl.path)
    private static var restRecordDataScheme = initRestRecordTable(db: db)
    
    /// If a restRecord's id equals it, then the restRecord hasn't been persisted into the database yet.
    static let NON_PERSISTENT_ID: Int64 = -1
    
    static func updateRestRecordById(restRecord: RestRecord) -> Void {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.id == restRecord.id)
            .update(
                restRecordDataScheme.startDate <- restRecord.startDate,
                restRecordDataScheme.endDate <- restRecord.endDate
            )
        try! db.run(query)
    }
    
    static func saveRestRecord(restRecord: RestRecord) -> Int64 {
        let insert = restRecordDataScheme.table.insert(
            restRecordDataScheme.startDate <- restRecord.startDate,
            restRecordDataScheme.endDate <- restRecord.endDate
        )
        return try! db.run(insert)
    }

    static func getRestRecords() -> [RestRecord] {
        return try! db.prepare(getBaiscRestRecordQuery()).map {
            return RestRecord(
                id: $0[restRecordDataScheme.id],
                startDate: $0[restRecordDataScheme.startDate],
                endDate: $0[restRecordDataScheme.endDate]!
            )
        }
    }
    
    static func upsertOngoingRest(startDate: Date) -> Void {
        deleteOngoingRest()
        try! db.run(restRecordDataScheme.table.insert(
            restRecordDataScheme.startDate <- startDate))
    }
    
    static func getOngoingRest() -> OngoingRest? {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.endDate === nil)
        // FIXME return nil when empty
        let queryRes = try! db.pluck(query)
        if queryRes == nil {
            return nil
        }
        return OngoingRest(startDate: queryRes![restRecordDataScheme.startDate])
    }
    
    static func getRestRecordAtDay(date: Date) -> [RestRecord] {
        let startOfDate = date.getStartOfDay()
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.shouldBelongToDay(day: date))
            .order(restRecordDataScheme.startDate.asc)
        let res: [RestRecord] = try! db.prepare(query)
            .map {
                let startDate: Date = $0[restRecordDataScheme.startDate]
                var endDate: Date = $0[restRecordDataScheme.endDate]!
                if startDate.getStartOfDay() == startOfDate && endDate.getStartOfDay() > startOfDate {
                    endDate = startDate.getEndOfDay()
                }
                return RestRecord(id: $0[restRecordDataScheme.id],
                                  startDate: startDate,
                                  endDate: endDate)
            }
        return res
    }

    static func resetDB() -> Void {
        if fileManager.fileExists(atPath: dbFileUrl.path) {
            try! fileManager.removeItem(atPath: dbFileUrl.path)
        }
        db = try! Connection(dbFileUrl.path)
        restRecordDataScheme = initRestRecordTable(db: db)
    }
    
    static func deleteOngoingRest() -> Void {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.endDate == nil)
        try! db.run(query.delete())
    }
    
    static func deleteRestRecordsByStartDate(startDate: Date) -> Void {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.shouldBelongToDay(day: startDate))
        try! db.run(query.delete())
    }
    
    static func deleteRestRecordById(restRecordId: Int64) -> Void {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.id == restRecordId)
        try! db.run(query.delete())
    }
    
    private static func getFileManager() -> FileManager {
        return FileManager.default
    }

    private static func getDataFilePath(fileManager: FileManager) -> URL {
        let folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let res = folderURL.appendingPathComponent("rest_time.data")
        return res
    }
    
    private static func initRestRecordTable(db: Connection) -> RestRecordDataScheme {
        return createRestRecordTableIfNotExists(db: db)
    }
    
    private static func createRestRecordTableIfNotExists(db: Connection) -> RestRecordDataScheme {
        let restRecords = Table("rest_records")
        let id = Expression<Int64>("id")
        let startDate = Expression<Date>("startDate")
        let endDate = Expression<Date?>("endDate")
        
        try! db.run(restRecords.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(startDate)
            t.column(endDate)
        })
        return RestRecordDataScheme(
            table: restRecords,
            id: id,
            startDate: startDate,
            endDate: endDate
        )
    }
    
    private static func getBaiscRestRecordQuery() -> QueryType {
        return restRecordDataScheme.table
            .filter(restRecordDataScheme.endDate != nil)
    }
    
}
