//
//  GridForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/25/24.
//

import SwiftUI

struct GridForFriendListView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let friends: [BFriend]
    let gridShapes: [any Shape] = [CustomRectangle1(), CustomRectangle2()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(friends, id: \.self) { friend in
                    VStack {
                        if let imageData = friend.profileImage,  // 인스턴스에서 접근
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(getRandomShape())
                        } else {
                            Image("photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 166, height: 166)
                                .clipShape(getRandomShape())
                        }
                        Text(friend.name ?? "")
                            .foregroundColor(.black)
                        //                        Text("D-\(BFriend.D_day)")
                        //                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: 랜덤으로 도형을 받아오는 함수
    private func getRandomShape() -> AnyShape {
            let shapes: [AnyShape] = [
                AnyShape(CustomRectangle1()),
                AnyShape(CustomRectangle2())
            ]
            return shapes.randomElement() ?? AnyShape(CustomRectangle1())
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
    
    // GridForFriendListView 반환
    GridForFriendListView(friends: dummyFriends)
}
