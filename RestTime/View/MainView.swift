//
//  MainView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var latestRestRecord = LatestRestRecord()
    @StateObject private var statRestRecords = StatRestRecords()
    
    @State private var statItemOptionsShown = false
    @State private var modifyStatItemShown = false
    @StateObject private var currentClickedRestRecord = CurrentClickedRestRecord()
    
    var body: some View {
        ZStack {
            TabView {
                ContentView(latestRestRecord: latestRestRecord)
                    .tabItem {
                        Label("Counter", systemImage: "list.dash")
                    }
                
                StatView(latestRestRecord: latestRestRecord,
                         statRestRecords: statRestRecords,
                         currentClickedRestRecord: currentClickedRestRecord,
                         setStatItemBottomCardVisibility: {
                    statItemOptionsShown = $0
                })
                    .tabItem {
                        Label("Statistics", systemImage: "square.and.pencil")
                            .accessibilityIdentifier("StatisticsTab")
                    }
            }
            Card(cardShown: $statItemOptionsShown, cardPos: .bottom, tapElsewhereToDismiss: true) {
                StatItemOptions(dismissHandler: { statItemOptionsShown = false }, deleteHandler: {
                    RestDataManager.deleteRestRecordById(restRecordId: currentClickedRestRecord.restRecord!.id)
                    statRestRecords.useRestRecords(statRestRecords.restRecords.filter {
                        $0.id != currentClickedRestRecord.restRecord!.id
                    })
                }, modifyHandler: {
                    modifyStatItemShown = true
                })
            }
            Card(cardShown: $modifyStatItemShown, cardPos: .middle, tapElsewhereToDismiss: false) {
                ModifyStatItem(currentClickedRestRecord: currentClickedRestRecord,
                                statRestRecords: statRestRecords,
                                shown: $modifyStatItemShown)
            }
            
        }
//        .onAppear {
//            // Insert test data for screenshots
//            RestDataManager.deleteRestRecordsByStartDate(startDate: Date())
//            let today = Date().toString(format: .date)
//            RestDataManager.saveRestRecord(restRecord: RestRecord(id: RestDataManager.NON_PERSISTENT_ID, startDate: "\(today) 08:00:00".toDate(), endDate: "\(today) 08:21:05".toDate()))
//            RestDataManager.saveRestRecord(restRecord: RestRecord(id: RestDataManager.NON_PERSISTENT_ID, startDate: "\(today) 19:20:01".toDate(), endDate: "\(today) 19:45:10".toDate()))
//            RestDataManager.saveRestRecord(restRecord: RestRecord(id: RestDataManager.NON_PERSISTENT_ID, startDate: "\(today) 22:01:00".toDate(), endDate: "\(today) 22:08:05".toDate()))
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
}
