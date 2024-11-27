//
//  SetNameForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetNameForSaveBdayView: View {

    @Binding var name: String

    var body: some View {
        //MARK: 이름 설정
        HStack {
            Text("이름")
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(hex: "F0F0F0"))
                .frame(width: 324, height: 43)
            TextField("", text: $name)
                .textFieldStyle(.plain)
                .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
        }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))
            .onAppear (perform : UIApplication.shared.hideKeyboard)
    }
}
