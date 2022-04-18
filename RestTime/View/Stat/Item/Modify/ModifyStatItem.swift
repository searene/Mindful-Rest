//
// Created by Joey Green on 2022/4/13.
//

import SwiftUI

struct ModifyStatItem: View {
    
    @ObservedObject var currentClickedRestRecord: CurrentClickedRestRecord
    @ObservedObject var statRestRecords: StatRestRecords
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @Binding var shown: Bool
    @State private var showTimeConstraintAlert = false
    
    init(currentClickedRestRecord: CurrentClickedRestRecord,
         statRestRecords: StatRestRecords,
         shown: Binding<Bool>) {
        self.currentClickedRestRecord = currentClickedRestRecord
        self.statRestRecords = statRestRecords
        self._shown = shown
        
        if currentClickedRestRecord.restRecord != nil {
            _startDate = State(initialValue: currentClickedRestRecord.restRecord!.startDate)
            _endDate = State(initialValue: currentClickedRestRecord.restRecord!.endDate)
        }
    }

    var body: some View {
        VStack(alignment: .trailing) {
            VStack {
                ModifyDateTime(label: "FROM", date: $startDate)
                    .padding(.bottom, 10)
                ModifyDateTime(label: "TO", date: $endDate)
                    .padding(.bottom, 10)
            }
            HStack {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xA3A3A3))
                    .frame(width: 86, height: 36)
                    .onTapGesture {
                        shown = false
                    }
                Text("OK")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 86, height: 36)
                    .background(Color(hex: 0x7982D3))
                    .cornerRadius(5)
                    .onTapGesture {
                        if startDate > endDate {
                            showTimeConstraintAlert = true
                            return
                        }
                        self.modifyDates()
                        shown = false
                    }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
        .alert(isPresented: $showTimeConstraintAlert) {
            Alert(title: Text("Error"),
                  message: Text("The start time must be less than the end time!"))
        }
        .padding(.top, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
    
    private func modifyDates() -> Void {
        let newRestRecord = RestRecord(
            id: currentClickedRestRecord.restRecord!.id,
            startDate: startDate,
            endDate: endDate)
        RestDataManager.updateRestRecordById(restRecord: newRestRecord)
        statRestRecords.useRestRecords(statRestRecords.restRecords
            .map {
                if $0.id == currentClickedRestRecord.restRecord!.id {
                    return newRestRecord
                } else {
                    return $0
                }
            })
    }
}

struct ModifyStatItem_Previews: PreviewProvider {
    
    @State static var shown: Bool = true
    
    static var previews: some View {
        ModifyStatItem(
            currentClickedRestRecord: CurrentClickedRestRecord(),
            statRestRecords: StatRestRecords(),
            shown: $shown)
        ModifyStatItem(
            currentClickedRestRecord: CurrentClickedRestRecord(),
            statRestRecords: StatRestRecords(),
            shown: $shown)
            .environment(\.locale, .init(identifier: "zh"))
    }
}
