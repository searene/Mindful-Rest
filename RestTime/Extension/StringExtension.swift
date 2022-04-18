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
    
    /// Convert the current String to a dict if it's a json string. An error may throw out if it's not a json string.
    func toDict() -> [String: Any] {
        let data: Data = data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
    
}
