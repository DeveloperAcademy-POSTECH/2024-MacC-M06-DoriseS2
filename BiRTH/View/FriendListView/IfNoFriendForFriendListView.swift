//
//  IfNoFriendForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/25/24.
//

import SwiftUI

struct IfNoFriendForFriendListView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.bottom, 10)
            
            Text("아직 친구가 없어요")
                .font(.biRTH_bold_18)
                .padding(.bottom, 5)
            
            Text("플러스 버튼을 눌러서 친구를 등록해봐요 😊 ")
                .font(.biRTH_regular_14)
            
            Spacer()
        }
        .background(Color.biRTH_mainColor)
    }
}

#Preview {
    IfNoFriendForFriendListView()
}
