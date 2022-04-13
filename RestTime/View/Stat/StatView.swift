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
    
    @State private var statItemOptionsShown = false
    @State private var statItemOptionsDismissed = false
    
    init(latestRestRecord: LatestRestRecord) {
        self.latestRestRecord = latestRestRecord
        let statDate = Date().getStartOfDay()
        _statDate = State(initialValue: statDate)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                getDatePickerView()
                Spacer(minLength: 30)
                // FIXME make the top distance the same as the bottom distance
                getTotalView(restRecords)
                Spacer(minLength: 30)
                getStatItemsView()
                Spacer()
            }
            .onAppear {
                restRecords = RestDataManager.getRestRecordAtDay(date: statDate)
//                        restRecords = [
//                            RestRecord(id: 1, startDate: "2020-03-15 10:00:00".toDate(), endDate: "2020-03-15 10:30:00".toDate()),
//                            RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate()),
//                            RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate())
//                        ]
            }
            
            BottomCard(cardShown: $statItemOptionsShown, cardDismissed: $statItemOptionsDismissed) {
                StatItemOptions()
            }
        }
    }
    
    @ViewBuilder
    private func getDatePickerView() -> some View {
        StyledDatePicker(selectedDate: $statDate)
            .onChange(of: statDate, perform: {
                restRecords = RestDataManager.getRestRecordAtDay(date: $0)
            })
    }
    
    @ViewBuilder
    private func getStatItemsView() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                if restRecords.count > 0 {
                    ForEach(Array(restRecords.enumerated()), id: \.element.id) { index, element in
                        StatItem(restRecords[index],
                                 isLastOne: index == restRecords.count - 1,
                                 removeItemHandler: { restRecordId in
                                    RestDataManager.deleteRestRecordById(restRecordId: restRecordId)
                                    self.restRecords = restRecords.filter { $0.id != restRecordId }
                                    // FIXME Also need to update the total rest time
                                 },
                                 clickHandler: { restRecordId in
                            
                        })
                    }
                }
            }
            .padding(.top, 20)
        }
        .background(Color(hex: 0xf5f5f5))
    }
    
    @ViewBuilder
    private func getTotalView(_ restRecords: [RestRecord]) -> some View {
        HStack {
            Text("TOTAL:")
                .font(Font.custom("BalooBhaijaan-Regular", size: 20))
                .foregroundColor(Color(hex: 0xc3c3c3))
            Text("\(RestRecord.getTotalDuration(restRecords).getFullDescription())")
                .font(Font.custom("BalooBhaijaan-Regular", size: 20))
                .foregroundColor(Color(hex: 0x818589))
        }
        
    }
    
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(latestRestRecord: LatestRestRecord())
    }
}
