//
//  RestRecordService.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/3.
//

import Foundation

struct RestRecord: Equatable {
    let startDate: Date
    let endDate: Date
    
    func toDict() -> [String: String] {
        return ["startDate": startDate.toString(),
                "endDate": endDate.toString()]
    }
    
    static func toDicts(restRecords: [RestRecord]) -> [[String: String]] {
        return restRecords.map { $0.toDict() }
    }
    
    static func fromDicts(dicts: [[String: String]]) -> [RestRecord] {
        return dicts.map { fromDict(dict: $0) }
    }
    
    static func fromDict(dict: [String: String]) -> RestRecord {
        let startDate = dict["startDate"]!.toDate()
        let endDate = dict["endDate"]!.toDate()
        return RestRecord(startDate: startDate, endDate: endDate)
    }
}

class RestRecordService {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
    }
    let fileManager: FileManager
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    func saveRestRecords(restRecords: [RestRecord]) {
        
    }
//    func save(fileNamed: String, data: Data) throws {
//        guard let url = makeURL(forFileNamed: fileNamed) else {
//            throw Error.invalidDirectory
//        }
//        if fileManager.fileExists(atPath: url.absoluteString) {
//            throw Error.fileAlreadyExists
//        }
//        do {
//            try data.write(to: url)
//        } catch {
//            debugPrint(error)
//            throw Error.writtingFailed
//        }
//    }
    private func getDataFilePath() -> URL {
        let folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return folderURL.appendingPathComponent("rest_time.data")
    }
}
