//
//  ListForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/25/24.
//

import SwiftUI

struct ListForFriendListView: View {
    var friends: [BFriend]
    
    var body: some View {
        List(friends, id: \.self) { friend in
            HStack {
                Group {
                    if let imageData = friend.profileImage,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(.circle)
                    } else {
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(.circle)
                    }
                }
                .padding(.leading, 21)
                .padding(.trailing, 15)
                
                Text(friend.name ?? "")
                    .font(.biRTH_semibold_14)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("D-11")
                    .font(.biRTH_bold_12)
                    .foregroundColor(.biRTH_text1)
                    .padding(.trailing, 10)
            } //: HSTACK
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    // 삭제
                } label: {
                    Label("Delete", systemImage: "minus.circle.fill")
                        .symbolRenderingMode(.palette)
                        .background(Color.red)
                }
                .tint(.biRTH_mainColor)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.biRTH_mainColor)
        } //: List
        .listStyle(.plain)
        .background(Color.biRTH_mainColor)
    }
}

#Preview {
    let viewContext = PersistenceController.preview.container.viewContext
    
    // 더미 데이터 생성 및 저장
    let dummyFriends: [BFriend] = {
        let friend1 = BFriend(context: viewContext)
        friend1.name = "시네필"
        friend1.profileImage = nil
        
        let friend2 = BFriend(context: viewContext)
        friend2.name = "친구"
        friend2.profileImage = nil
        
        let friend3 = BFriend(context: viewContext)
        friend3.name = "가족"
        friend3.profileImage = nil
        
        try? viewContext.save()
        
        return [friend1, friend2, friend3]
    }()
    
    // ListForFriendListView 반환
    ListForFriendListView(friends: dummyFriends)
}
