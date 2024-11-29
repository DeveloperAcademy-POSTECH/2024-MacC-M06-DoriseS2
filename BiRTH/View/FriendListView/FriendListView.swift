//
//  Temp_FriendListView.swift
//  BiRTH
//
//  Created by 이소현 on 11/28/24.
//

import SwiftUI

struct FriendListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var text: String = ""
    @State var selectedViewMode: ViewMode = .grid
    @State var isGridView = ViewMode.noFriend
    @State var sortingMethod = "생일 가까운 순"
    @State var tagName = [""]
    @State var tagColor = [""]
    
    @FetchRequest(entity: BTag.entity(), sortDescriptors: []) var bTags: FetchedResults<BTag>
    @FetchRequest(entity: BFriend.entity(), sortDescriptors: []) var bFriend: FetchedResults<BFriend>
    
    let gridShapes: [any Shape] = [CustomRectangle1(), CustomRectangle2()]
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - HeaderView
                HeaderForFriendList(
                    text: $text,
                    sortingMethod: $sortingMethod,
                    selectedViewMode: $selectedViewMode,
                    isGridView: $isGridView
                )
                
                TagsInFriendList(
                    bTags: bTags,
                    tagName: $tagName,
                    tagColor: $tagColor
                )
                
            
                // MARK: - Grid Or ListView
                FriendGridORListView(
                    isGridView: $isGridView,
                    text: $text,
                    tagName: $tagName,
                    sortingMethod: $sortingMethod,
                    bFriend: bFriend
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            .background(Color.biRTH_mainColor)
            
        }
        
    }
}


#Preview {
    FriendListView()
}
