//
//  SetTagView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetTagView: View {

    var bTags: BTag?

    @State private var tagName = ""
    @State private var tagColor = "F0F0F0"

    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("태그 생성")
                    .font(.biRTH_bold_28)
                    .foregroundStyle(.black)
                    .padding(.leading, 11)


                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 20, trailing: 0))

            TextFieldForTagView(tagName: $tagName)
            ChoosingColorOfTagView(tagColor: $tagColor)

            Spacer()

            ButtonOfSavingBTagView(tagName: $tagName, tagColor: $tagColor, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
        }
        .background(.white)
        .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
    }
}
