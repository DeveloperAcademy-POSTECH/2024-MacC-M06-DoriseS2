//
//  ButtonOfShowingSheetForSettingDateView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ButtonOfShowingSheetForSettingDateView: View {

    @Binding var isshowingSheetForSettingDate: Bool

    var body: some View {
        VStack {
            Button {
                isshowingSheetForSettingDate.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.biRTH_pointColor)
                        .frame(width: 300, height: 48)
                    Text("선택 완료")
                        .font(Font.biRTH_bold_16)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    ButtonOfShowingSheetForSettingDateView(isshowingSheetForSettingDate: .constant(true))
}
