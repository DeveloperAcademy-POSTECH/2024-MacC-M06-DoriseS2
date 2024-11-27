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

// MARK: TextFieldCustomForSearchBar
struct SearchBarStyleForFriendListView: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {

        ZStack {
            RoundedRectangle(cornerRadius: 90)
                .frame(width: 288, height: 45)
                .foregroundColor(Color.gray.opacity(0.2))

            HStack {
                Text(Image(systemName: "magnifyingglass"))
                    .foregroundColor(Color.black)
                    .font(.system(size: 24))

                configuration
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(.leading, 31)
        }

    }
}

//#Preview {
//    @Previewable @State var searchText = ""
//    SearchBarForFriendListView(text: $searchText)
//}

