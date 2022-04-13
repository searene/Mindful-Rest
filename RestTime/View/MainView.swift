//
//  MainView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var latestRestRecord = LatestRestRecord()
    
    @State private var statItemOptionsShown = false
    @State private var statItemOptionsDismissed = false
    
    var body: some View {
        ZStack {
            TabView {
                ContentView(latestRestRecord: latestRestRecord)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                StatView(latestRestRecord: latestRestRecord,
                         setStatItemBottomCardVisibility: {
                    statItemOptionsShown = $0
                })
                    .tabItem {
                        Label("Statistics", systemImage: "square.and.pencil")
                            .accessibilityIdentifier("StatisticsTab")
                    }
            }
            BottomCard(cardShown: $statItemOptionsShown, cardDismissed: $statItemOptionsDismissed) {
                StatItemOptions()
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
