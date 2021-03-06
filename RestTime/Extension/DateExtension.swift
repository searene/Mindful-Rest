//
//  DateFormatter.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

extension Date {
    
    var previousDay: Date {
        Calendar.current.date(byAdding: DateComponents(day:-1), to: self)!
    }
        
    var nextDay: Date {
        Calendar.current.date(byAdding: DateComponents(day:+1), to: self)!
    }
    
    func toString(format: DateFormatType = DateFormatType.localDateTimeSec) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        return dateFormatter.string(from: self)
    }
    
    /// Get the string to represent the duration, e.g. 10:30, which represents 10 minutes 30 seconds
    func getDurationString(endDate: Date) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: self, to: endDate)
        
        let strMin = String(format: "%02d", difference.minute ?? 00)
        let strSec = String(format: "%02d", difference.second ?? 00)
        
        return "\(strMin):\(strSec)"
    }
    
    func getStartOfDay() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))!
    }
    
    func getEndOfDay() -> Date {
        let components = DateComponents(hour: 23, minute: 59, second: 59)
        return Calendar.current.date(byAdding: components, to: self.getStartOfDay())!
    }
    
    func plusMinutes(_ minutes: Double) -> Date {
        return self + minutes * 60
    }
    
}
