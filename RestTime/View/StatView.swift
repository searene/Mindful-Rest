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
        VStack(alignment: .center, spacing: 0) {
            DatePicker("Please enter a date", selection: $statDate, displayedComponents: .date)
                .labelsHidden()
                .padding()
            List(RestDataManager.getRestRecordAtDay(date: statDate)) { restRecord in
                HStack(spacing: 0) {
                    Text("\(restRecord.startDate.toString(format: .localTimeSec)) ~ \(restRecord.endDate.toString(format: .localTimeSec))")
                    Spacer()
                    Button("Modify", action: {
                        
                    })
                }
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
