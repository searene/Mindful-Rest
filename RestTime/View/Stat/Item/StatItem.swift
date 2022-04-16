//
//  StatItem.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/5.
//

import SwiftUI

struct StatItem: View {
    
    @Binding var restRecord: RestRecord
    @Binding var proportion: Float
    private let removeItemHandler: (_ restRecordId: Int64) -> Void
    private let clickHandler: (_ restRecordId: Int64) -> Void
    
    private let isLastOne: Bool
    
    init(restRecord: Binding<RestRecord>,
         proportion: Binding<Float>,
         isLastOne: Bool,
         removeItemHandler: @escaping (_ restRecordId: Int64) -> Void,
         clickHandler: @escaping (_ restRecordId: Int64) -> Void) {
        self._restRecord = restRecord
        self._proportion = proportion
        self.isLastOne = isLastOne
        self.removeItemHandler = removeItemHandler
        self.clickHandler = clickHandler
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                getStartDateText(startDate: restRecord.startDate)
                getDurationLabel(startDate: restRecord.startDate, endDate: restRecord.endDate)
                Spacer(minLength: 25)
            }
            if !isLastOne {
                getVerticalLine()
            }
        }
        .padding(.top, -5)
    }
    
    @ViewBuilder
    private func getStartDateText(startDate: Date) -> some View {
        Text("\(startDate.toString(format: .hourAndMinute))")
            .frame(width: 80)
            .foregroundColor(Color(hex: 0x818589))
    }
    
    private func getDurationLabel(startDate: Date, endDate: Date) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            
            Text(Duration.fromDates(startDate, endDate).getFullDescription())
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .font(Font.custom("Rubik-Regular", size: 16))
            .onTapGesture {
                withAnimation {
                    self.clickHandler(restRecord.id)
                }
            }
            
        }
        .overlay(GeometryReader { proxy in
            Color(hex: 0x7683D7)
                .frame(width: getDurationLineWidth(proxy.size.width, proportion), height: 5)
                .padding(.top, proxy.size.height)
        })
    }
    
    private func getDurationLineWidth(_ totalWidth: CGFloat, _ proportion: Float) -> CGFloat {
        if proportion < 0.05 {
            return totalWidth * 0.05
        } else {
            return totalWidth * CGFloat(proportion)
        }
    }
    
    private func getVerticalLine() -> some View {
        return Color(hex: 0xc5c5c5)
            .frame(width: 1, height: 30)
            .padding(.top, -5)
            .padding(.leading, 40)
    }
}

struct StatItem_Previews: PreviewProvider {
    
    @State static var restRecord = RestRecord(
                id: 1,
                startDate: "2020-03-20 10:00:00".toDate(),
                endDate: "2020-03-20 11:00:00".toDate())
    @State static var proportion: Float = 0.1
    
    static var previews: some View {
        VStack {
            StatItem(restRecord: $restRecord, proportion: $proportion, isLastOne: true, removeItemHandler: {
                print($0)
            }, clickHandler: {
                print($0)
            })
            .padding(.top, 50)
            .padding(.bottom, 50)
        }
        .background(Color(hex: 0xf5f5f5))
    }
}
