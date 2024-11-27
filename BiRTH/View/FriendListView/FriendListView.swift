//
//  FriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/21/24.
//

import SwiftUI

struct FriendListView: View {
    @State private var text = ""
    @State var viewMode: ListModeToggle.ViewMode = .grid
    @State var sortingMethod = "생일 가까운 순"
    @State var isGridView = true
    @State var isDdaySort = true
    @State private var relationshipTag = [""]

    @FetchRequest(
        entity: BFriend.entity(),
        sortDescriptors: []
    )
    private var bFriend: FetchedResults<BFriend>

    @State private var isshowingSheetForCreatingTag = false
    
    @FetchRequest(
        entity: BTag.entity(),
        sortDescriptors: []
    )
    private var bTags: FetchedResults<BTag>


    var body: some View {
        NavigationView{
            VStack {
                SearchBarForFriendListView(text: $text)
                HeaderForFriendListView(viewMode: $viewMode, isGridView: $isGridView, isDdaySort: $isDdaySort, bFriend: bFriend)
                    .padding(.bottom, 18)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        TagsInFriendListView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                    } .padding(.leading, 25)
                }
                
                Spacer()
                
                
                if isGridView {
                    GridForFriendListView(bFriend: bFriend)
                } else {
                    ListForFriendListView(bFriend: bFriend)
                }
            }
            .background(Color.biRTH_mainColor)
        }
    }
}

