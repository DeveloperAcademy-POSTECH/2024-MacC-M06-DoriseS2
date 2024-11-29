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

    @FetchRequest(entity: BFriend.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BFriend.birth, ascending: true)])
    private var bFriend: FetchedResults<BFriend>

    @State private var isshowingSheetForCreatingTag = false
    @FetchRequest(entity: BTag.entity(), sortDescriptors: [])
    private var bTags: FetchedResults<BTag>
    
    let ddayUtils = DdayUtils()
    
    
    var sortedFriends: [BFriend] {
        if isDdaySort {
            return bFriend.sorted { friend1, friend2 in
                guard let birth1 = friend1.birth, let birth2 = friend2.birth else { return false }
                let dday1 = ddayUtils.calculateDday(birth: birth1)
                let dday2 = ddayUtils.calculateDday(birth: birth2)
                return dday1 < dday2
            }
        } else {
            return bFriend.sorted { ($0.name ?? "") < ($1.name ?? "") }
        }
    }
    


    var body: some View {
        NavigationStack {
            VStack {
                SearchBarForFriendListView(text: $text)
                HeaderForFriendListView(viewMode: $viewMode, isGridView: $isGridView, isDdaySort: $isDdaySort, sortingMethod: $sortingMethod)
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

