//
//  RestFileManager.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

func saveRestRecords(restRecords: [RestRecord]) -> Void {
    let fileManager = getFileManager()
    let restRecordsStr = ["records": RestRecord.toDicts(restRecords: restRecords)].toJSONString()
    let filePath = getDataFilePath(fileManager: fileManager)
    try! restRecordsStr.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
}

func getRestRecords() -> [RestRecord] {
    let fileManager = getFileManager()
    let filePath = getDataFilePath(fileManager: fileManager)
    // FIXME test return empty array when file doesn't exist
    if !fileManager.fileExists(atPath: filePath.path) {
        return []
    }
    let restRecordsStr: String = try! String(contentsOf: filePath, encoding: .utf8)
    let restRecordsDicts: [[String: String]] = restRecordsStr.toDict()["records"] as! [[String: String]]
    return RestRecord.fromDicts(dicts: restRecordsDicts)
}

func deleteDataFile() -> Void {
    let fileManager = getFileManager()
    let filePath = getDataFilePath(fileManager: fileManager)
    try! fileManager.removeItem(atPath: filePath.path)
}

private func getFileManager() -> FileManager {
    return FileManager.default
}

private func getDataFilePath(fileManager: FileManager) -> URL {
    let folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    return folderURL.appendingPathComponent("rest_time.data")
}
