//
//  DateUtils.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

public enum DateFormatType {
    
    /// The local formatted date and time "yyyy-MM-dd HH:mm:ss" i.e. 1997-07-16 19:20:00
    case localDateTimeSec
    
    case localTimeSec
    
    var stringFormat: String {
        switch self {
        //handle iso Time
        case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
        case .localTimeSec: return "HH:mm:ss"
        }
    }
}

