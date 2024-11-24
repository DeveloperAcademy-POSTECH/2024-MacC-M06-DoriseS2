//
//  SetBirthForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetBirthForSaveBdayView: View {

    @Binding var isLunar: Bool
    @Binding var dateOfBday: Date
    @Binding var isshowingSheetForSettingDate: Bool

    var body: some View {
        //MARK: 생일 날짜 설정
        HStack(alignment: .bottom) {
            Text("생일")
                .font(.system(size: 18, weight: .semibold))

            Spacer()
        }.padding(.init(top: 5, leading: 45, bottom: 1, trailing: 45))

        HStack {

//            ButtonForCheckingIsLunar(isLunar: $isLunar)

            ButtonForCheckingTheDate(isLunar: $isLunar, dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate)

            Spacer()

        }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))
    }
}
