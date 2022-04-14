//
//  ModifyDateTime.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/14.
//

import SwiftUI

struct ModifyDateTime: View {
    
    let label: String;
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(Font.custom("BalooBhaijaan-Regular", size: 16))
                .foregroundColor(Color(hex: 0x2063C7))
            HStack(spacing: 0) {
                DatePicker("Please enter the date", selection: $date)
                    .labelsHidden()
            }
        }
    }
}

struct ModifyDateTime_Previews: PreviewProvider {
    
    @State private static var date = Date()
    
    static var previews: some View {
        ModifyDateTime(label: "FROM", date: $date)
    }
}
