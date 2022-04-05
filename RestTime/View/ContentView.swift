//
//  ContentView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/2.
//

import SwiftUI

let START_RESTING: String = "Start Resting"
let STOP: String = "Stop"

let fileManager: FileManager = .default
let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

let restRecords = [RestRecord]()

struct ContentView: View {
    
    @State private var startDate = Date()
    @State private var timerString = "00:00"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var buttonTitle: String = START_RESTING
    
    var body: some View {
        VStack {
            if buttonTitle == STOP {
                Text("\(timerString)")
                    .onReceive(timer) { input in
                        timerString = startDate.getDurationString(endDate: Date())
                    }
            }
            Button(buttonTitle, action: {
                if buttonTitle == START_RESTING {
                    buttonTitle = STOP
                    startDate = Date()
                } else {
                    let restRecord = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                                startDate: startDate,
                                                endDate: Date())
                    RestDataManager.saveRestRecord(restRecord: restRecord)
                    buttonTitle = START_RESTING
                    timerString = "00:00"
                }
            })
            .tint(.blue)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
