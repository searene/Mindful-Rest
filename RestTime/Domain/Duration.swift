//
//  Duration.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/5.
//

import Foundation

struct Duration: Equatable {
    
    let durationInSeconds: Int
    
    private let hours: Int
    private let minutes: Int
    private let seconds: Int
    
    init(durationInSeconds: Int) {
        self.durationInSeconds = durationInSeconds
        hours = durationInSeconds / 3600
        minutes = (durationInSeconds % 3600) / 60
        seconds = (durationInSeconds % 3600) % 60
    }
    
    static func fromDates(_ startDate: Date, _ endDate: Date) -> Duration {
        let seconds = Int(endDate.timeIntervalSince(startDate))
        return Duration(durationInSeconds: seconds)
    }
    
    func getFullDescription() -> String {
        let hoursStr = getHoursStr(hours)
        let minutesStr = getMinutesStr(minutes)
        let secondsStr = getSecondsStr(seconds)
        if hours > 0 {
            return "\(hoursStr) \(minutesStr) \(secondsStr)"
        } else if (minutes > 0) {
            return "\(minutesStr) \(secondsStr)"
        } else {
            return "\(secondsStr)"
        }
    }
    
    func getShortDescription() -> String {
        if durationInSeconds < 60 {
            return "\(durationInSeconds) seconds"
        }
        return "\(durationInSeconds / 60) minutes"
    }
    
    static func +(left: Duration, right: Duration) -> Duration {
        return Duration(durationInSeconds: left.durationInSeconds + right.durationInSeconds)
    }
    
    private func getHoursStr(_ hours: Int) -> String {
        return String(hours) + " h"
    }
    
    private func getMinutesStr(_ minutes: Int) -> String {
        return String(minutes) + " m"
    }
    
    private func getSecondsStr(_ seconds: Int) -> String {
        return String(seconds) + " s"
    }
    
    private func toStr(_ num: Int) -> String {
        return String(num)
    }
}
