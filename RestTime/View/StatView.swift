//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct StatView: View {
    
    @State private var statDate = Date.now.onlyReserveDate()
    
    var body: some View {
        let restRecords = RestDataManager.getRestRecordAtDay(date: statDate)
        VStack(alignment: .center, spacing: 0) {
            DatePicker("Please enter a date", selection: $statDate, displayedComponents: .date)
                .labelsHidden()
                .padding()
            Spacer()
//            Text("total: " + \(getTotalDurationStr(restRecords))
            List(restRecords) { restRecord in
                StatItem(restRecord)
            }
            Spacer()
        }
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}
