//
//  ButtonForCheckingTheDate.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ButtonForCheckingTheDate: View {

    @Binding var isLunar: Bool
    @Binding var dateOfBday: Date
    @Binding var isshowingSheetForSettingDate: Bool

    var body: some View {
        HStack {
            Button {
                isshowingSheetForSettingDate.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.init(hex: "F0F0F0"))
                        .frame(width: 123, height: 34)
                    Text("\(dateOfBday, formatter: SaveBdayView.dateFormat)")
                        .font(.biRTH_regular_18)
                        .foregroundColor(.biRTH_pointColor)
                }
            }
            .sheet(isPresented: $isshowingSheetForSettingDate) {
                SetDateView(dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate, isLunar: $isLunar)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
            }
        }
    }
}
