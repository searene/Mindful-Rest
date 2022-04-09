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
        DatePicker("Please select the date", selection: $selectedDate, displayedComponents: .date)
            .labelsHidden()
            .padding()
    }
}

struct StyledDatePicker_Previews: PreviewProvider {
    
    @State private static var date = Date()
    
    static var previews: some View {
        StyledDatePicker(selectedDate: $date)
    }
}
