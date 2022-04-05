//
//  RestDataManager.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation
import SQLite

struct RestRecordDataScheme {
    let table: Table;
    let id: Expression<Int64>;
    let startDate: Expression<Date>;
    let endDate: Expression<Date>;
}

struct RestDataManager {
    
    private static let fileManager = getFileManager()
    private static let dbFileUrl = getDataFilePath(fileManager: fileManager)
    private static var db = try! Connection(dbFileUrl.path)
    private static var restRecordDataScheme = initRestRecordTable(db: db)
    
    static func saveRestRecord(restRecord: RestRecord) -> Void {
        let insert = restRecordDataScheme.table.insert(
            restRecordDataScheme.startDate <- restRecord.startDate,
            restRecordDataScheme.endDate <- restRecord.endDate
        )
        try! db.run(insert)
    }

    static func getRestRecords() -> [RestRecord] {
        let res = try! db.prepare(restRecordDataScheme.table).map {
            return RestRecord(
                startDate: $0[restRecordDataScheme.startDate],
                endDate: $0[restRecordDataScheme.endDate]
            )
        }
        return res
    }
    
    static func getRestRecordAtDay(date: Date) -> [RestRecord] {
        let query = restRecordDataScheme.table
            .filter(restRecordDataScheme.startDate >= date && restRecordDataScheme.startDate < date.nextDay)
            .order(restRecordDataScheme.startDate.desc)
        return try! db.prepare(query)
            .map {
                return RestRecord(startDate: $0[restRecordDataScheme.startDate],
                                  endDate: $0[restRecordDataScheme.endDate])
            }
    }

    static func resetDB() -> Void {
        if fileManager.fileExists(atPath: dbFileUrl.path) {
            try! fileManager.removeItem(atPath: dbFileUrl.path)
        }
        db = try! Connection(dbFileUrl.path)
        restRecordDataScheme = initRestRecordTable(db: db)
    }
    
    private static func getFileManager() -> FileManager {
        return FileManager.default
    }

    private static func getDataFilePath(fileManager: FileManager) -> URL {
        let folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let res = folderURL.appendingPathComponent("rest_time.data")
        print("db url")
        print(res)
        return res
    }
    
    private static func initRestRecordTable(db: Connection) -> RestRecordDataScheme {
        return createTableIfNotExists(db: db)
    }
    
    private static func createTableIfNotExists(db: Connection) -> RestRecordDataScheme {
        let restRecords = Table("rest_records")
        let id = Expression<Int64>("id")
        let startDate = Expression<Date>("startDate")
        let endDate = Expression<Date>("endDate")
        
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
    
}

