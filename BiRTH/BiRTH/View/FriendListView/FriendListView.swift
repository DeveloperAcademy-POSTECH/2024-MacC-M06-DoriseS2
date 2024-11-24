//
//  FriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/21/24.
//

import SwiftUI

struct FriendListView: View {
    @Binding var text: String
    var body: some View {
        VStack {
            SearchBarForFriendListView(text: $text)
            HeaderForFriendListView()
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var searchText = ""
    FriendListView(text: $searchText)
}
