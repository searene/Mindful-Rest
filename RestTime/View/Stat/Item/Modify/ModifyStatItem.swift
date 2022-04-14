//
// Created by Joey Green on 2022/4/13.
//

import SwiftUI

struct ModifyStatItem: View {
    
    @ObservedObject var currentClickedRestRecord: CurrentClickedRestRecord
    @State var startDate: Date
    @State var endDate: Date

    var body: some View {
        VStack {
            ModifyDateTime(label: "FROM", date: $startDate)
            ModifyDateTime(label: "TO", date: $endDate)
            HStack {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0xA3A3A3))
                    .frame(width: 86, height: 36)
                Text("OK")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 86, height: 36)
                    .background(Color(hex: 0x7982D3))
                    .cornerRadius(5)
            }
            .padding(.top, 30)
        }
        .padding()
    }
}

struct ModifyStatItem_Previews: PreviewProvider {
    
    static var previews: some View {
        ModifyStatItem(currentClickedRestRecord: CurrentClickedRestRecord(), startDate: Date(), endDate: Date())
    }
}
