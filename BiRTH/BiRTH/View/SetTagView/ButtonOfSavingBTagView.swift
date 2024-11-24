//
//  ButtonOfSavingBTagView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ButtonOfSavingBTagView: View {
    @Environment(\.managedObjectContext) var viewContext

    @Binding var tagName: String
    @Binding var tagColor: String
    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        VStack {
            Button {
                createBTag(viewContext: viewContext, tagName: tagName, tagColor: tagColor)
                isshowingSheetForCreatingTag.toggle()

            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.biRTH_pointColor)
                        .frame(width: 300, height: 48)
                    Text("추가")
                        .font(Font.biRTH_bold_16)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

//extension ButtonOfSavingBTagView {
//    func saveBTag() {
//        let newBdayTag = BdayTag(id: UUID(), tagName: tagName, tagColor: tagColor)
//        contextForBTag.insert(newBdayTag)
//    }
//}
