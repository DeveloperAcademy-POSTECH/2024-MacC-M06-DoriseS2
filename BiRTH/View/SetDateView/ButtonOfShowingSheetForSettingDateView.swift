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
                        .fill(.black)
                        .frame(width: 340, height: 60)
                    Text("완료")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
