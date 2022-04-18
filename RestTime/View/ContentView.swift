//
//  ContentView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/2.
//

import SwiftUI

let START_RESTING: LocalizedStringKey = "START RESTING"
let STOP: LocalizedStringKey = "STOP"

let fileManager: FileManager = .default
let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

let restRecords = [RestRecord]()

struct ContentView: View {
    
    @State private var startDate: Date
    @State private var timerString: String
    @State private var buttonTitle: LocalizedStringKey
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var latestRestRecord: LatestRestRecord
    
    init(latestRestRecord: LatestRestRecord) {
        self.latestRestRecord = latestRestRecord
        let ongoingRest = RestDataManager.getOngoingRest()
        if ongoingRest != nil {
            // Continue resting
            _startDate = State(initialValue: ongoingRest!.startDate)
            _timerString = State(initialValue: ongoingRest!.startDate.getDurationString(endDate: Date()))
            _buttonTitle = State(initialValue: STOP)
        } else {
            // Resting hasn't been started
            _startDate = State(initialValue: Date())
            _timerString = State(initialValue: "00:00")
            _buttonTitle = State(initialValue: START_RESTING)
        }
    }
    
    var body: some View {
        VStack {
            Text("\(timerString)")
                .foregroundColor(.blue)
                .font(.system(size: 70))
                .onReceive(timer) { input in
                    timerString = buttonTitle == START_RESTING ? "00:00" : startDate.getDurationString(endDate: Date())
                }
            Button(buttonTitle, action: {
                if buttonTitle == START_RESTING {
                    startDate = Date()
                    RestDataManager.upsertOngoingRest(startDate: startDate)
                    buttonTitle = STOP
                    startTimer()
                } else {
                    let restRecord = RestRecord(id: RestDataManager.NON_PERSISTENT_ID,
                                                startDate: startDate,
                                                endDate: Date())
                    RestDataManager.deleteOngoingRest()
                    let id = RestDataManager.saveRestRecord(restRecord: restRecord)
                    latestRestRecord.restRecord = RestRecord(id: id, startDate: restRecord.startDate, endDate: restRecord.endDate)
                    buttonTitle = START_RESTING
                    timerString = "00:00"
                    stopTimer()
                }
            })
//            .tint(.blue)
//            .controlSize(.large)
//            .buttonStyle(.borderedProminent)
        }
    }
    
    private func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    private func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(latestRestRecord: LatestRestRecord())
        }
    }
}
