//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

// FIXME automatically select the next when passes the midnight
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
            Spacer(minLength: 30)
            HStack {
                Text("TOTAL:")
                    .font(Font.custom("BalooBhaijaan-Regular", size: 20))
                    .foregroundColor(Color(hex: 0xc3c3c3))
                Text("\(RestRecord.getTotalDuration(restRecords).getFullDescription())")
                    .font(Font.custom("BalooBhaijaan-Regular", size: 20))
                    .foregroundColor(Color(hex: 0x818589))
            }
            // FIXME make the top distance the same as the bottom distance
            Spacer(minLength: 30)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    if restRecords.count > 0 {
                        ForEach((0...restRecords.count - 1), id: \.self) { recordId in
                            StatItem(restRecords[recordId], isLastOne: recordId == restRecords.count - 1, { restRecordId in
                                RestDataManager.deleteRestRecordById(restRecordId: restRecordId)
                                restRecords = restRecords.filter { $0.id != restRecordId }
                                // FIXME Also need to update the total rest time
                            })
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            restRecords = RestDataManager.getRestRecordAtDay(date: statDate)
//                    restRecords = [
//                        RestRecord(id: 1, startDate: "2020-03-15 10:00:00".toDate(), endDate: "2020-03-15 10:30:00".toDate()),
//                        RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate()),
//                        RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate())
//                    ]
        }
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(latestRestRecord: LatestRestRecord())
    }
}
