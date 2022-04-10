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
    private let isLastOne: Bool
    
    init(_ restRecord: RestRecord, isLastOne: Bool, _ removeItemHandler: @escaping (_ restRecordId: Int64) -> Void) {
        restRecordId = restRecord.id
        self.isLastOne = isLastOne
        startDate = restRecord.startDate
        _endDate = State(initialValue: restRecord.endDate)
        self.removeItemHandler = removeItemHandler
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                getStartDateText(startDate: startDate)
                getDurationLabel(startDate: startDate, endDate: endDate)
                Spacer(minLength: 25)
            }
            if !isLastOne {
                getVerticalLine()
            }
        }
        .padding(.top, -5)
    }
    
    @ViewBuilder
    private func getStartDateText(startDate: Date) -> some View {
        Text("\(startDate.toString(format: .hourAndMinute))")
            .frame(width: 100)
            .foregroundColor(Color(hex: 0x818589))
    }
    
    private func getDurationLabel(startDate: Date, endDate: Date) -> some View {
        return Text(Duration.fromDates(startDate, endDate).getFullDescription())
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.yellow)
            .font(Font.custom("Rubik-Regular", size: 16))
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
    
    private func getVerticalLine() -> some View {
        return Color(hex: 0xc5c5c5)
            .frame(width: 1, height: 30)
            .padding(.top, -5)
            .padding(.leading, 50)
    }
}

struct StatItem_Previews: PreviewProvider {
    static var previews: some View {
        StatItem(RestRecord(
            id: 1,
            startDate: "2020-03-20 10:00:00".toDate(),
            endDate: "2020-03-20 11:00:00".toDate()
        ), isLastOne: false, {
            print($0)
        })
    }
}
