//
//  StatItem.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/5.
//

import SwiftUI

struct StatItem: View {
    
    private let restRecordId: Int64
    private let startDate: Date
    @State private var endDate: Date
    @State private var showEndDatePicker = false
    
    init(_ restRecord: RestRecord) {
        restRecordId = restRecord.id
        startDate = restRecord.startDate
        _endDate = State(initialValue: restRecord.endDate)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(startDate.toString(format: .localTimeSec)) ~ \(endDate.toString(format: .localTimeSec))")
            Spacer()
            Button("Modify End Time", action: {
                showEndDatePicker = true
            })
            .popover(isPresented: $showEndDatePicker) {
                DatePicker("Please enter the end date", selection: $endDate)
                    .labelsHidden()
                    .padding()
                    .onChange(of: endDate, perform: { selectedEndDate in
                        /// FIXME difference between the two parameters?
                        let restRecord = RestRecord(
                            id: restRecordId,
                            startDate: startDate,
                            endDate: selectedEndDate)
                        RestDataManager.updateRestRecordById(restRecord: restRecord)
                    })
                Button("OK", action: {
                    showEndDatePicker = false
                })
            }
        }
    }
}

struct StatItem_Previews: PreviewProvider {
    static var previews: some View {
        StatItem(RestRecord(
            id: 1,
            startDate: "2020-03-20 10:00:00".toDate(),
            endDate: "2020-03-21 11:00:00".toDate()
        ))
    }
}
