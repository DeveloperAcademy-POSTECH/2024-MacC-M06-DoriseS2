//
//  Temp_HeaderForFriendList.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//

import SwiftUI

// MARK: - HeaderForFriendList
struct HeaderForFriendList: View {
    
    @Binding var text: String
    @Binding var sortingMethod: String
    @Binding var selectedViewMode: ViewMode
    @Binding var isGridView: Bool
    
    var body: some View {
        SearchBarForFriendListView(text: $text)
        
        HStack {
            Text("나의 친구")
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
            
            Menu {
                Button("생일 가까운 순") {
                    sortingMethod = "생일 가까운 순"
                    print(sortingMethod)
                }
                Button("이름 순") {
                    sortingMethod = "이름 순"
                    print(sortingMethod)
                }
            } label: {
                HStack {
                    Image(systemName: "triangle")
                        .font(.system(size: 8))
                        .rotationEffect(.degrees(180))
                        .foregroundStyle(.gray)
                    
                    Text(sortingMethod)
                        .font(.biRTH_regular_14)
                        .foregroundStyle(.gray)
                }
            }
            
            Divider()
                .frame(height: 18)
            
            HStack {
                
                Button {
                    withAnimation {
                        selectedViewMode = .grid
                    }
                    
                    isGridView = true
                    
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(selectedViewMode == .grid ? .black : .gray.opacity(0.5))
                }
                
                
                Button {
                    withAnimation {
                        selectedViewMode = .list
                    }
                    
                    isGridView = false
                } label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(selectedViewMode == .list ? .black : .gray.opacity(0.5))
                }
            }
            .font(.system(size: 20))
        }
    }
}


// MARK: - SearchBarForFriendListView
struct SearchBarForFriendListView: View {
    @Binding var text: String
    
    var body: some View {
        HStack(alignment: .center) {
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
            
        }
        
    }
}

// MARK: TextFieldCustomForSearchBar
struct SearchBarStyleForFriendListView: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 90)
                .frame(width: 288, height: 45)
                .foregroundColor(Color.gray.opacity(0.2))
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.black)
                    .font(.system(size: 24))
                
                configuration
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(10)
        }
        
    }
}
