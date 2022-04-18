//
//  StatView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct StatView: View {
    
    @State private var statDate: Date
    @ObservedObject private var latestRestRecord: LatestRestRecord
    @ObservedObject var currentClickedRestRecord: CurrentClickedRestRecord
    @ObservedObject var statRestRecords: StatRestRecords
    
    @State private var statItemOptionsDismissed = false
    private let setStatItemBottomCardVisibility: (_ visible: Bool) -> Void
    
    init(latestRestRecord: LatestRestRecord,
         statRestRecords: StatRestRecords,
         currentClickedRestRecord: CurrentClickedRestRecord,
         setStatItemBottomCardVisibility: @escaping (_ visible: Bool) -> Void) {
        
        self.latestRestRecord = latestRestRecord
        self.statRestRecords = statRestRecords
        self.currentClickedRestRecord = currentClickedRestRecord
        let statDate = Date().getStartOfDay()
        _statDate = State(initialValue: statDate)
        self.setStatItemBottomCardVisibility = setStatItemBottomCardVisibility
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                getDatePickerView()
                Spacer(minLength: 30)
                getTotalView(statRestRecords.restRecords)
                Spacer(minLength: 30)
                getStatItemsView()
                Spacer()
            }
            .onAppear {
                statDate = Date().getStartOfDay()
                statRestRecords.useRestRecords(RestDataManager.getRestRecordAtDay(date: statDate))
                
//                statRestRecords.useRestRecords([
//                    RestRecord(id: 1, startDate: "2020-03-15 10:00:00".toDate(), endDate: "2020-03-15 10:30:00".toDate()),
//                    RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate()),
//                    RestRecord(id: 2, startDate: "2020-03-15 15:00:00".toDate(), endDate: "2020-03-15 15:30:00".toDate())
//                ])
            }
            
        }
    }
    
    @ViewBuilder
    private func getDatePickerView() -> some View {
        DatePickerWithArrows(selectedDate: $statDate)
            .onChange(of: statDate, perform: {
                statRestRecords.useRestRecords(RestDataManager.getRestRecordAtDay(date: $0))
            })
            .padding(.top, 20)
    }
    
    @ViewBuilder
    private func getStatItemsView() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                if statRestRecords.restRecords.count > 0 {
                    ForEach(Array(statRestRecords.restRecords.enumerated()), id: \.element.id) { index, element in
                        StatItem(restRecord: $statRestRecords.restRecords[index],
                                 proportion: $statRestRecords.proportions[index],
                                 isLastOne: index == statRestRecords.restRecords.count - 1,
                                 removeItemHandler: { restRecordId in
                                    RestDataManager.deleteRestRecordById(restRecordId: restRecordId)
                                    statRestRecords.useRestRecords(restRecords.filter { $0.id != restRecordId })
                                 },
                                 clickHandler: { restRecordId in
                            let restRecord = statRestRecords.restRecords.filter {$0.id == restRecordId}[0]
                                    currentClickedRestRecord.restRecord = restRecord
                                    setStatItemBottomCardVisibility(true)
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
    
    @StateObject private static var currentClickedRestRecord = CurrentClickedRestRecord()
    
    static var previews: some View {
        StatView(latestRestRecord: LatestRestRecord(),
                 statRestRecords: StatRestRecords(),
                 currentClickedRestRecord: currentClickedRestRecord,
                 setStatItemBottomCardVisibility: { print($0) })
    }
}
