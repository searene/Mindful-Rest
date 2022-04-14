//
// Created by Joey Green on 2022/4/13.
//

import SwiftUI

struct ModifyStatItem: View {
    
    @ObservedObject var currentClickedRestRecord: CurrentClickedRestRecord
    @ObservedObject var statRestRecords: StatRestRecords
    @State var startDate: Date
    @State var endDate: Date
    @Binding var shown: Bool

    var body: some View {
        VStack {
            ModifyDateTime(label: "FROM", date: $startDate)
            ModifyDateTime(label: "TO", date: $endDate)
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
                        self.modifyDates()
                        shown = false
                    }
            }
            .padding(.top, 30)
        }
        .padding()
    }
    
    private func modifyDates() -> Void {
        let newRestRecord = RestRecord(
            id: currentClickedRestRecord.restRecord!.id,
            startDate: startDate,
            endDate: endDate)
        RestDataManager.updateRestRecordById(restRecord: newRestRecord)
        statRestRecords.restRecords = statRestRecords.restRecords
            .map {
                if $0.id == currentClickedRestRecord.restRecord!.id {
                    return newRestRecord
                } else {
                    return $0
                }
            }
    }
}

struct ModifyStatItem_Previews: PreviewProvider {
    
    @State static var shown: Bool = true
    
    static var previews: some View {
        ModifyStatItem(
            currentClickedRestRecord: CurrentClickedRestRecord(),
            statRestRecords: StatRestRecords(),
            startDate: Date(),
            endDate: Date(),
            shown: $shown)
    }
}
