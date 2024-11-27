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
        VStack(alignment: .leading)  {
            Text("이름")
                .font(.biRTH_semibold_20)
                .padding(.leading, 22)
                .padding(.bottom, 13)
             TextField("이름 입력", text: $name)
                .textFieldStyle(CommonTextfieldStyle())
                .onAppear (perform : UIApplication.shared.hideKeyboard)
        }
    }
}

struct CommonTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            // 텍스트필드
            configuration
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 38)
            Rectangle()
                .frame(width: 286, height: 1)
                .foregroundColor(Color.purple)
                .padding(.leading, 29.5)
                .padding(.trailing, 59.5)
        }
    }
}

#Preview {
    SetNameForSaveBdayView(name: .constant(""))
}
