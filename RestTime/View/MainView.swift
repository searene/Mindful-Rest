//
//  MainView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var latestRestRecord = LatestRestRecord()
    
    var body: some View {
        TabView {
            ContentView(latestRestRecord: latestRestRecord)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            StatView(latestRestRecord: latestRestRecord)
                .tabItem {
                    Label("Statistics", systemImage: "square.and.pencil")
                        .accessibilityIdentifier("StatisticsTab")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
