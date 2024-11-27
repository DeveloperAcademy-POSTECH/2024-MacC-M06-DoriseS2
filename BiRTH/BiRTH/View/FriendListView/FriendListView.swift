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
                        ChooseTagsInSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
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

//#Preview {
//    // Core Data 컨텍스트 생성
//    let context = PersistenceController.preview.container.viewContext
//    
//    // 태그 데이터 생성
//    let tag1 = BTag(context: context)
//    tag1.id = UUID()
//    tag1.name = "친구"
//    tag1.color = "#FFC0CB"
//    
//    let tag2 = BTag(context: context)
//    tag2.id = UUID()
//    tag2.name = "가족"
//    tag2.color = "#FFD700"
//    
//    let tag3 = BTag(context: context)
//    tag3.id = UUID()
//    tag3.name = "애플디벨로퍼아카데미"
//    tag3.color = "#ADFF2F"
//    
//    // 친구 데이터 생성
//    let friend1 = BFriend(context: context)
//    friend1.id = UUID()
//    friend1.name = "김철수"
//    friend1.birth = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//    friend1.tags = ["친구"]
//    friend1.noti = []
//    
//    let friend2 = BFriend(context: context)
//    friend2.id = UUID()
//    friend2.name = "이영희"
//    friend2.birth = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
//    friend2.tags = ["가족"]
//    friend2.noti = []
//    
//    let friend3 = BFriend(context: context)
//    friend3.id = UUID()
//    friend3.name = "박영수"
//    friend3.birth = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
//    friend3.tags = ["동료"]
//    friend3.noti = []
//    
//    try? context.save()
//    
//    return FriendListView(
//        text: .constant(""),
//        friends: [friend1, friend2, friend3]
//    )
//    .environment(\.managedObjectContext, context)
//}
