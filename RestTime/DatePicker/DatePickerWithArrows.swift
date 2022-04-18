//
//  StyledDatePicker.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/9.
//

import SwiftUI

struct DatePickerWithArrows: View {
    
    @Binding var selectedDate: Date
    
    private let PLEASE_SELECT: LocalizedStringKey = "Please select the date"
    
    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "arrowtriangle.left.fill")
                        .foregroundColor(Color(hex: 0xc4c4c4))
                        .scaleEffect(1.5)
                        .onTapGesture {
                            selectedDate = selectedDate.previousDay
                        }
                DatePicker(PLEASE_SELECT, selection: $selectedDate, displayedComponents: .date)
                        .labelsHidden()
                        .id(selectedDate)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                
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
}

struct StyledDatePicker_Previews: PreviewProvider {
    
    @State private static var date = Date()
    
    static var previews: some View {
        DatePickerWithArrows(selectedDate: $date)
    }
}
