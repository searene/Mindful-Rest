//
//  RestRecordService.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/3.
//

import Foundation

struct RestRecord: Equatable, Identifiable {
    let id: Int64
    let startDate: Date
    let endDate: Date
    
    func withNewEndDate(_ newEndDate: Date) -> RestRecord {
        return RestRecord(id: id, startDate: startDate, endDate: newEndDate)
    }
    
    func getDuration() -> Duration {
        return Duration.fromDates(startDate, endDate)
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
    private func getDataFilePath() -> URL {
        let folderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return folderURL.appendingPathComponent("rest_time.data")
    }
}
