//
//  DateFormatter.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

extension Date {
    
    func toString(format: DateFormatType = DateFormatType.localDateTimeSec) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        return dateFormatter.string(from: self)
    }
}
