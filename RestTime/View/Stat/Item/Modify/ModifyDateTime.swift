//
//  ModifyDateTime.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/14.
//

import SwiftUI

struct ModifyDateTime: View {
    
    let label: LocalizedStringKey;
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // FIXME Different font for different localizations
            Text(label)
                .font(getFont())
                .foregroundColor(Color(hex: 0x2063C7))
            HStack(spacing: 0) {
                DatePicker("Please enter the date", selection: $date)
                    .labelsHidden()
            }
        }
    }
    
    private func getFont() -> Font {
        let fontSize: CGFloat = 14
        if getAppLanguage() == .zh {
            return .system(size: fontSize)
        } else {
            return .custom("BalooBahaijaan-Regular", size: fontSize)
        }
    }
}

struct ModifyDateTime_Previews: PreviewProvider {
    
    @State private static var date = Date()
    
    static var previews: some View {
        ModifyDateTime(label: "FROM", date: $date)
        ModifyDateTime(label: "开始时间", date: $date)
            .environment(\.locale, .init(identifier: "zh"))
    }
}
