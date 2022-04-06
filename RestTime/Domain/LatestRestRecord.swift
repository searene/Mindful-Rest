//
//  TodayRestRecords.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/5.
//

import Foundation

class LatestRestRecord: ObservableObject {
    @Published var restRecord: RestRecord? = nil
}
