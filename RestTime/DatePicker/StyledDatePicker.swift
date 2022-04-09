//
//  StyledDatePicker.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/9.
//

import SwiftUI

struct StyledDatePicker: View {
    
    @Binding var selectedDate: Date
    
    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
    }
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "arrowtriangle.left.fill")
                .foregroundColor(Color(hex: 0xc4c4c4))
                .scaleEffect(1.5)
                .onTapGesture {
                    selectedDate = selectedDate.previousDay
                }
            DatePicker("Please select the date", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .padding()
                .id(selectedDate)
            Image(systemName: "arrowtriangle.right.fill")
                .foregroundColor(Color(hex: 0xc4c4c4))
                .scaleEffect(1.5)
                .onTapGesture {
                    selectedDate = selectedDate.nextDay
                }
            Spacer()
        }
    }
}

struct StyledDatePicker_Previews: PreviewProvider {
    
    @State private static var date = Date()
    
    static var previews: some View {
        StyledDatePicker(selectedDate: $date)
    }
}
