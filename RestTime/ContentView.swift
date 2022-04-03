//
//  ContentView.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/2.
//

import SwiftUI

let START_RESTING: String = "Start Resting"
let RESTING: String = "Resting..."

extension Date {
    func passedTime(from date: Date) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: date, to: self)
        
        let strMin = String(format: "%02d", difference.minute ?? 00)
        let strSec = String(format: "%02d", difference.second ?? 00)
        
        return "\(strMin):\(strSec)"
    }
}

struct ContentView: View {
    
    @State private var startTime = Date()
    @State private var timerString = "00:00"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var buttonTitle: String = START_RESTING
    
    var body: some View {
        VStack {
            if buttonTitle == RESTING {
                Text("\(timerString)")
                    .onReceive(timer) { input in
                        timerString = Date().passedTime(from: startTime)
                    }
            }
            Button(buttonTitle, action: {
                if buttonTitle == START_RESTING {
                    buttonTitle = RESTING
                    startTime = Date()
                } else {
                    buttonTitle = START_RESTING
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
        ContentView()
    }
}
