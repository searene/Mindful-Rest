//
//  StringExtension.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

extension String {
    
    func toDate(format: DateFormatType = DateFormatType.localDateTimeSec) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        return dateFormatter.date(from: self)!
    }
}
