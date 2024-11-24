//
//  HeaderForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/24/24.
//

import SwiftUI

struct HeaderForFriendListView: View {
    @State var viewMode: ListModeToggle.ViewMode = .grid
    
    var body: some View {
        HStack {
            Text("나의 친구")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 31)
            
            Spacer()
            SortingMethodPicker()
            
            Divider()
                .frame(height: 17.5)
            
            ListModeToggle(selectedMode: $viewMode)
                .padding(.trailing, 23)
            
        } //: HSTACK
    }
}

// MARK: Sorting Method Picker
struct SortingMethodPicker: View {
    @State var selectedItem = "생일 가까운 순"
    var items = ["생일 가까운 순", "이름 순"]
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    selectedItem = item
                }) {
                    Text(item)
                }
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "triangle")
                    .font(.system(size: 8))
                    .rotationEffect(.degrees(180))
                    .foregroundColor(.gray)
                
                Text(selectedItem)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: List Mode Toggle
struct ListModeToggle: View {
    @Binding var selectedMode: ViewMode
    
    enum ViewMode {
        case grid, list
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                withAnimation {
                    selectedMode = .grid
                }
            }) {
                Image(systemName: "square.grid.2x2")
                    .foregroundColor(selectedMode == .grid ? .black : .gray.opacity(0.5))
            }
            
            Button(action: {
                withAnimation {
                    selectedMode = .list
                }
            }) {
                Image(systemName: "list.bullet")
                    .foregroundColor(selectedMode == .list ? .black : .gray.opacity(0.5))
            }
        }
        .font(.system(size: 20))
    }
}

#Preview {
    HeaderForFriendListView()
}
