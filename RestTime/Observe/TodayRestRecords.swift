//
//  TodayRestRecords.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/5.
//

import Foundation

class TodayRestRecords: ObservableObject {
    @Published var restRecords: [RestRecord] = RestDataManager.getRestRecordAtDay(date: Date().onlyReserveDate())
}
