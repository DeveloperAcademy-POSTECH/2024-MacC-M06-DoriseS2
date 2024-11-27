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
                        .fill(.black)
                        .frame(width: 340, height: 60)
                    Text("추가")
                        .font(.system(size: 20, weight: .bold))
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
