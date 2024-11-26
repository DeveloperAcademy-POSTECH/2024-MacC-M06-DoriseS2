//
//  ColByMyselfTopView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct ColByMyselfTopView: View {
    
    var friendImage: String
    var friendName: String
    var remainDday: Int
    
    var body: some View {
        HStack(spacing: 20) {
            NavigationLink {
                // TODO: FriendDetailView 연결
                TempFriendDetailView()
            } label: {
                ZStack {
                    Image(friendImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .mask {
                            Circle()
                        }
                    
                    magnifyImage()
                }
            }
            
            Text("TO.\(friendName)")
                .font(.biRTH_semibold_18)
            Spacer()
            Text("D-\(remainDday)")
                .font(.biRTH_semibold_16)
                .foregroundStyle(Color.biRTH_text2)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct magnifyImage: View {
    var body: some View {
        ZStack {
            Image(systemName: "magnifyingglass.circle.fill")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .offset(x: 15, y: 15)
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 20))
                .foregroundStyle(.black)
                .offset(x: 15, y: 15)
            
        }
    }
}

#Preview {
    ColByMyselfTopView(friendImage: "exampleImage", friendName: "임찬우", remainDday: 5)
}
