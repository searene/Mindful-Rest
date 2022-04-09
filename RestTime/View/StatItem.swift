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
    private let removeItemHandler: (_ restRecordId: Int64) -> Void
    @State private var endDate: Date
    @State private var showEndDatePicker = false
    
    init(_ restRecord: RestRecord, _ removeItemHandler: @escaping (_ restRecordId: Int64) -> Void) {
        restRecordId = restRecord.id
        startDate = restRecord.startDate
        _endDate = State(initialValue: restRecord.endDate)
        self.removeItemHandler = removeItemHandler
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(startDate.toString(format: .localTimeSec)) ~ \(endDate.toString(format: .localTimeSec))")
            Spacer()
            Text(Duration.fromDates(startDate, endDate).getShortDescription())
               .padding(10)
               .background(Color.yellow)
        }
        .swipeActions(allowsFullSwipe: false) {
            Button("Delete", role: .destructive, action: {
                removeItemHandler(restRecordId)
            })
            
            Button("Modify", action: {
                showEndDatePicker = true
            })
            .tint(.green)
        }
        .popover(isPresented: $showEndDatePicker) {
            Text("Please enter the end time")
            DatePicker("Please enter the end time", selection: $endDate)
                .labelsHidden()
                .padding()
                .onChange(of: endDate, perform: { selectedEndDate in
                    let restRecord = RestRecord(
                        id: restRecordId,
                        startDate: startDate,
                        endDate: selectedEndDate)
                    RestDataManager.updateRestRecordById(restRecord: restRecord)
                    // FIXME Also need to update the total rest time
                })
            Button("OK", action: {
                showEndDatePicker = false
            })
        }
    }
}

struct StatItem_Previews: PreviewProvider {
    static var previews: some View {
        StatItem(RestRecord(
            id: 1,
            startDate: "2020-03-20 10:00:00".toDate(),
            endDate: "2020-03-20 11:00:00".toDate()
        ), {
            print($0)
        })
    }
}
