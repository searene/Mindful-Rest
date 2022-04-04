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

func getDurationString(startDate: Date, endDate: Date) -> String {
    let difference = Calendar.current.dateComponents([.minute, .second], from: startDate, to: endDate)
    
    let strMin = String(format: "%02d", difference.minute ?? 00)
    let strSec = String(format: "%02d", difference.second ?? 00)
    
    return "\(strMin):\(strSec)"
}


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
                        timerString = getDurationString(startDate: startDate, endDate: Date())
                    }
            }
            Button(buttonTitle, action: {
                print(urls)

                if buttonTitle == START_RESTING {
                    buttonTitle = STOP
                    startDate = Date()
                } else {
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
