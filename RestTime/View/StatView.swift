//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct StatView: View {
    
    @State private var statDate: Date
    @ObservedObject private var todayRestRecords: TodayRestRecords
    
    init(todayRestRecords: TodayRestRecords) {
        self.todayRestRecords = todayRestRecords
        let statDate = Date().onlyReserveDate()
        _statDate = State(initialValue: statDate)
    }
    
    var body: some View {
        /// FIXME What should we do if the app passes the midnight?
//        onlyKeepTodayRecords(todayRestRecords)
        let restRecords = Date() == statDate
                ? todayRestRecords.restRecords
                : RestDataManager.getRestRecordAtDay(date: statDate)
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
    
    private func onlyKeepTodayRecords(_ todayRestRecords: TodayRestRecords) {
        todayRestRecords.restRecords = todayRestRecords.restRecords.filter {
            return $0.startDate < Date().nextDay.onlyReserveDate()
        }
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(todayRestRecords: TodayRestRecords())
    }
}
