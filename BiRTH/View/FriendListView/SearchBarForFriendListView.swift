//
//  SearchBarForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/24/24.
//

import SwiftUI

struct SearchBarForFriendListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("친구를 찾아보세요", text: $text)
                .textFieldStyle(SearchBarStyleForFriendListView())
                .padding(.leading, 16)
            
            NavigationLink {
                SaveBdayView()
            } label: {
                Image("AddButton")
                    .resizable()
                    .frame(width: 46, height: 47)
            }
            .padding(.trailing, 16)
        } //: HSATCK
    }
}



//#Preview {
//    @Previewable @State var searchText = ""
//    SearchBarForFriendListView(text: $searchText)
//}

