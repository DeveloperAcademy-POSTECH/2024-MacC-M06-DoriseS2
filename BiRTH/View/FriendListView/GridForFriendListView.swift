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
    var bFriend: FetchedResults<BFriend>

    let gridShapes: [any Shape] = [CustomRectangle1(), CustomRectangle2()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bFriend, id: \.self) { friend in
                    NavigationLink {
                        CollageByMyselfView(bFriend: friend)
//                        SaveBdayView(bFriend: friend)
                    } label: {
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

