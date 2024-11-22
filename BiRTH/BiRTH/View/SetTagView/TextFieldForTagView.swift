//
//  TextFieldForTagView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct TextFieldForTagView: View {

    @Binding var tagName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(hex: "F0F0F0"))
                .frame(width: 324, height: 48)

            TextField("입력한 내용을 태그 목록에 추가됩니다.", text: $tagName)
                .textFieldStyle(.plain)
                .padding(.init(top: 0, leading: 25, bottom: 0, trailing: 25))
        }.padding(.init(top: 0, leading: 25, bottom: 20, trailing: 25))
    }
}
