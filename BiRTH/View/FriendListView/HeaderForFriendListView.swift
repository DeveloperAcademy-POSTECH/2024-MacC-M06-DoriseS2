//
//  HeaderForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/24/24.
//

import SwiftUI

struct HeaderForFriendListView: View {
    @Binding var viewMode: ListModeToggle.ViewMode
    @Binding var isGridView: Bool
    @Binding var isDdaySort: Bool
    @Binding var sortingMethod: String

    var body: some View {
        HStack {
            Text("나의 친구")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 31)
            
            Spacer()
            SortingMethodPicker(sortingMethod: $sortingMethod, isDdaySort: $isDdaySort)

            Divider()
                .frame(height: 17.5)
            
            ListModeToggle(selectedMode: $viewMode, isGridView: $isGridView)
                .padding(.trailing, 23)
            
        } //: HSTACK
    }
}

// MARK: Sorting Method Picker
struct SortingMethodPicker: View {
    @Binding var sortingMethod: String
    @Binding var isDdaySort: Bool

    var body: some View {
        Menu {
            Button ("생일 가까운 순") {
                sortingMethod = "생일 가까운 순"
                isDdaySort = true
            }
            Button ("이름 순") {
                sortingMethod = "이름 순"
                isDdaySort = false
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "triangle")
                    .font(.system(size: 8))
                    .rotationEffect(.degrees(180))
                    .foregroundColor(.gray)
                
                Text(sortingMethod)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: List Mode Toggle
struct ListModeToggle: View {
    @Binding var selectedMode: ViewMode
    @Binding var isGridView: Bool
    
    enum ViewMode {
        case grid, list
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                withAnimation {
                    selectedMode = .grid
                }
                isGridView = true
                
            }) {
                Image(systemName: "square.grid.2x2")
                    .foregroundColor(selectedMode == .grid ? .black : .gray.opacity(0.5))
            }
            
            Button(action: {
                withAnimation {
                    selectedMode = .list
                }
                isGridView = false
            }) {
                Image(systemName: "list.bullet")
                    .foregroundColor(selectedMode == .list ? .black : .gray.opacity(0.5))
            }
        }
        .font(.system(size: 20))
    }
}
