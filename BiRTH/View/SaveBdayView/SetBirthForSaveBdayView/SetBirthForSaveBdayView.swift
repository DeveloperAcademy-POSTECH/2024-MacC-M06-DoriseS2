//
//  SetBirthForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetBirthForSaveBdayView: View {

    @Binding var dateOfBday: Date
    @Binding var isshowingSheetForSettingDate: Bool

    var body: some View {
        //MARK: 생일 날짜 설정
        HStack(alignment: .bottom) {
            Text("생년월일")
                .font(.biRTH_semibold_20)
                .padding(.leading, 22)
                .padding(.bottom, 16)

            Spacer()
        }

        HStack {

//            ButtonForCheckingIsLunar(isLunar: $isLunar)

            ButtonForCheckingTheDate(dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate)

            Spacer()

        } .padding(.leading, 21)
    }
}

#Preview {
    SetBirthForSaveBdayView(dateOfBday: .constant(Date()), isshowingSheetForSettingDate: .constant(false))
}
