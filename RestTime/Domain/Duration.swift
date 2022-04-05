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
    
    func toString() -> String {
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
    
    static func +(left: Duration, right: Duration) -> Duration {
        return Duration(durationInSeconds: left.durationInSeconds + right.durationInSeconds)
    }
    
    private func getHoursStr(_ hours: Int) -> String {
        if hours <= 1 {
            return String(hours) + " hour"
        } else {
            return String(hours) + " hours"
        }
    }
    
    private func getMinutesStr(_ minutes: Int) -> String {
        if minutes <= 1 {
            return String(minutes) + " minute"
        } else {
            return String(minutes) + " minutes"
        }
    }
    
    private func getSecondsStr(_ seconds: Int) -> String {
        if seconds <= 1 {
            return String(seconds) + " second"
        } else {
            return String(seconds) + " seconds"
        }
    }
    
    private func toStr(_ num: Int) -> String {
        return String(num)
    }
}
