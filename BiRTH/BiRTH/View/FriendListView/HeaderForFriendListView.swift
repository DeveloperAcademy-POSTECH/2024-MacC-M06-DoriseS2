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
    
    let friends: [BFriend]
    
    var body: some View {
        HStack {
            Text("나의 친구")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 31)
            
            Spacer()
            SortingMethodPicker(isDdaySort: $isDdaySort, friends: friends)
            
            Divider()
                .frame(height: 17.5)
            
            ListModeToggle(selectedMode: $viewMode, isGridView: $isGridView)
                .padding(.trailing, 23)
            
        } //: HSTACK
    }
}

// MARK: Sorting Method Picker
struct SortingMethodPicker: View {
    @State var selectedItem = "생일 가까운 순"
    var items = ["생일 가까운 순", "이름 순"]
    @Binding var isDdaySort: Bool
    let friends: [BFriend]
    let ddayUtils = DdayUtils()
    
    var sortedFriends: [BFriend] {
            if selectedItem == "생일 가까운 순" {
                // D-day 기준 정렬
                return friends.sorted { friend1, friend2 in
                    guard let birth1 = friend1.birth,
                          let birth2 = friend2.birth else {
                        return false
                    }
                    
                    // D-day 계산
                    let dday1 = ddayUtils.calculateDday(birth: birth1)
                    let dday2 = ddayUtils.calculateDday(birth: birth2)
                    
                    // D-day 숫자 추출
                    let number1 = Int(dday1.replacingOccurrences(of: "D-", with: "")) ?? Int.max
                    let number2 = Int(dday2.replacingOccurrences(of: "D-", with: "")) ?? Int.max
                    
                    return number1 < number2
                }
            } else {
                // 이름 기준 정렬
                return friends.sorted { ($0.name ?? "") < ($1.name ?? "") }
            }
        }



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

#Preview {
    let context = PersistenceController.preview.container.viewContext
    
    // 더미 데이터 생성
    let dummyFriends: [BFriend] = {
        let friend1 = BFriend(context: context)
        friend1.name = "시네필"
        friend1.profileImage = nil
        friend1.birth = Calendar.current.date(byAdding: .day, value: 21, to: Date())
        
        let friend2 = BFriend(context: context)
        friend2.name = "친구"
        friend2.profileImage = nil
        friend2.birth = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        
        try? context.save()
        
        return [friend1, friend2]
    }()
    
    return HeaderForFriendListView(
        viewMode: .constant(.grid),
        isGridView: .constant(true),
        isDdaySort: .constant(true),
        friends: dummyFriends
    )
}
