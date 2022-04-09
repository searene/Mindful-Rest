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
    @State private var restRecords: [RestRecord] = []
    
    init(latestRestRecord: LatestRestRecord) {
        self.latestRestRecord = latestRestRecord
        let statDate = Date().getStartOfDay()
        _statDate = State(initialValue: statDate)
    }
    
    var body: some View {
        return VStack(alignment: .center, spacing: 0) {
            StyledDatePicker(selectedDate: $statDate)
                .onChange(of: statDate, perform: {
                    restRecords = RestDataManager.getRestRecordAtDay(date: $0)
                })
            Spacer()
            Text("total: \(RestRecord.getTotalDuration(restRecords).getFullDescription())")
            List(restRecords) { restRecord in
                StatItem(restRecord, { restRecordId in
                    RestDataManager.deleteRestRecordById(restRecordId: restRecord.id)
                    restRecords = restRecords.filter { $0.id != restRecordId }
                    // FIXME Also need to update the total rest time
                })
            }
            Spacer()
        }
        .onAppear {
            restRecords = RestDataManager.getRestRecordAtDay(date: statDate)
        }
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(latestRestRecord: LatestRestRecord())
    }
}
