//
//  ShowingBTagOfSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ShowingBTagOfSaveBdayView: View {
    
    var bTags: FetchedResults<BTag>
    
    @Binding var relationshipTag: [String]
    @Binding var isshowingSheetForCreatingTag: Bool
    
    var body: some View {
        //MARK: 태그 설정
        VStack {
            Text("태그")
                .font(.biRTH_semibold_20)
                .padding(.leading, 22)
                .padding(.bottom, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ChooseTagsInSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                    
                    ButtonForMovingToSetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                    
                }
            }
        }
    }
}
