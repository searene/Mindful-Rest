//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct StatView: View {
    
    @State private var statDate: Date
    @ObservedObject private var latestRestRecord: LatestRestRecord
    
    init(latestRestRecord: LatestRestRecord) {
        self.latestRestRecord = latestRestRecord
        let statDate = Date().getStartOfDay()
        _statDate = State(initialValue: statDate)
    }
    
    var body: some View {
        let restRecords = RestDataManager.getRestRecordAtDay(date: statDate)
        return VStack(alignment: .center, spacing: 0) {
            DatePicker("Please enter a date", selection: $statDate, displayedComponents: .date)
                .labelsHidden()
                .padding()
            Spacer()
            Text("total: \(RestRecord.getTotalDuration(restRecords).toString())")
            List(restRecords) { restRecord in
                StatItem(restRecord)
            }
            Spacer()
        }
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(latestRestRecord: LatestRestRecord())
    }
}
