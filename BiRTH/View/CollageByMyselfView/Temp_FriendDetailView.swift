//
//  TempFriendDetailView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct Temp_FriendDetailView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("CollageByMyselfView") {
                CollageByMyselfView()
            }
        }
    }
}

#Preview {
    Temp_FriendDetailView()
}
