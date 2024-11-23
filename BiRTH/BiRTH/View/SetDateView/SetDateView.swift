//
//  SetDateView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetDateView: View {

    @Binding var dateOfBday: Date
    @Binding var isshowingSheetForSettingDate: Bool
    @Binding var isLunar: Bool

    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("생일 날짜")
                    .font(.system(size: 30, weight: .bold))

                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 1, trailing: 0))

            if isLunar {
//                IsLunarDateTextView(dateOfBday: $dateOfBday)
            }

            Spacer()

            DatePickerOfSetDateView(dateOfBday: $dateOfBday)

            Spacer()

            ButtonOfShowingSheetForSettingDateView(isshowingSheetForSettingDate: $isshowingSheetForSettingDate)
        }
        .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
    }
}
