//
//  ShowingBTagOfSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ShowingBTagOfSaveBdayView: View {

    var bTags: [BTag]

    @Binding var relationshipTag: [String]
    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        //MARK: 태그 설정
        HStack {
            Text("태그")
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ChooseTagsInSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)

                ButtonForMovingToSetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)

            }
        }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))
    }
}
