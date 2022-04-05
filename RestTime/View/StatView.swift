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
        VStack(alignment: .leading, spacing: 0) {
            DatePicker("Please enter a date", selection: $statDate, displayedComponents: .date)
                .labelsHidden()
            List(RestDataManager.getRestRecordAtDay(date: statDate)) { restRecord in
                Text("\(restRecord.startDate) ~ \(restRecord.endDate)")
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
