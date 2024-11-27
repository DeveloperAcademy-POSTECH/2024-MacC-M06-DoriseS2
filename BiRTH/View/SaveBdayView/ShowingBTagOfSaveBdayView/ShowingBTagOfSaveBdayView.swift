//
//  ShowingBTagOfSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI
import CoreData

struct ShowingBTagOfSaveBdayView: View {
    
    var bTags: FetchedResults<BTag>
    
    @Binding var relationshipTag: [String]
    @Binding var isshowingSheetForCreatingTag: Bool
    
    var body: some View {
        //MARK: 태그 설정
        VStack (alignment: .leading){
            Text("태그")
                .font(.biRTH_semibold_20)
                .padding(.leading, 22)
                .padding(.bottom, 13)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 12) {
                    ChooseTagsInSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                    
                    ButtonForMovingToSetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                    
                } .padding(.leading, 26)
            }
        }
    }
}

#Preview {
    struct PreviewContainer: View {
            @FetchRequest(
                entity: BTag.entity(),
                sortDescriptors: []
            ) private var bTags: FetchedResults<BTag>
            
            var body: some View {
                ShowingBTagOfSaveBdayView(
                    bTags: bTags,
                    relationshipTag: .constant([]),
                    isshowingSheetForCreatingTag: .constant(false)
                )
            }
        }
        
        return PreviewContainer()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
