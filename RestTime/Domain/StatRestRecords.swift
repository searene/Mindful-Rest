//
//  StatRestRecords.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/13.
//

import Foundation

class StatRestRecords: ObservableObject {
    @Published var restRecords: [RestRecord] = []
    
    @Published var proportions: [Float] = []
    
    func useRestRecords(restRecords: [RestRecord]) -> Void {
        self.restRecords = restRecords
        self.proportions = restRecords.enumerated().map { index, record in
            RestRecord.getDurationProportion(restRecords: restRecords, targetIndex: index)
        }
    }
}
