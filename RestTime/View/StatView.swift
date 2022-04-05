//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct StatView: View {
    
    @State private var statDate: Date;
    @State private var restRecords: [RestRecord] = [];
    
    init() {
        let statDate = Date().onlyReserveDate()
        _statDate = State(initialValue: statDate)
        _restRecords = State(initialValue: getRestRecords(statDate))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
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
    
    private func getRestRecords(_ statDate: Date) -> [RestRecord] {
        return RestDataManager.getRestRecordAtDay(date: statDate)
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}
