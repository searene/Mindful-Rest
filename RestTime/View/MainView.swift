//
//  MainView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var todayRestRecords = TodayRestRecords()
    
    var body: some View {
        TabView {
            ContentView(todayRestRecords: todayRestRecords)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            StatView(todayRestRecords: todayRestRecords)
                .tabItem {
                    Label("Statistics", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
