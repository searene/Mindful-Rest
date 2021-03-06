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
    
    static func getTotalDuration(_ restRecords: [RestRecord]) -> Duration {
        return restRecords.map { $0.getDuration() }
            .reduce(Duration(durationInSeconds: 0)) { $0 + $1 }
    }
    
    static func getDurationProportion(restRecords: [RestRecord], targetIndex: Int) -> Float {
        let totalDurationInSeconds = getTotalDuration(restRecords).durationInSeconds
        let targetDurationInSeconds = restRecords[targetIndex].getDuration().durationInSeconds
        return Float(targetDurationInSeconds) / Float(totalDurationInSeconds)
    }
    
}

