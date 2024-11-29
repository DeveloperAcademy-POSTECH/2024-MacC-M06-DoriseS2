//
//  Temp_FriendListView.swift
//  BiRTH
//
//  Created by 이소현 on 11/28/24.
//

import SwiftUI


enum Temp_ViewMode {
    case grid, list
}


struct Temp_FriendListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var text: String = ""
    @State var selectedViewMode: Temp_ViewMode = .grid
    @State var isGridView = true
    @State var sortingMethod = "생일 가까운 순"
    @State var tagName = [""]
    @State var tagColor = [""]
    
    @FetchRequest(entity: BTag.entity(), sortDescriptors: []) var bTags: FetchedResults<BTag>
    @FetchRequest(entity: BFriend.entity(), sortDescriptors: []) var bFriend: FetchedResults<BFriend>
    
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let gridShapes: [any Shape] = [CustomRectangle1(), CustomRectangle2()]
    
    // 검색
    var filteredFriends: [BFriend] {
        if text.isEmpty {
            return Array(bFriend)
        } else {
            return bFriend.filter { friend in
                (friend.name ?? "").localizedCaseInsensitiveContains(text)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            // MARK: - HeaderView
            VStack {
                Temp_SearchBarForFriendListView(text: $text)
                
                // MARK: - HeaderForFriendListView
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
                
                // MARK: - TagsInFriendListView
                ScrollView(.horizontal) {
                    /*LazyHGrid(rows: rows)*/ HStack {
                        ForEach(bTags) { bTag in
                            Button {
                                if let name = bTag.name, let color = bTag.color {
                                    if tagName.contains(name), tagColor.contains(color) {
                                        tagName.removeAll { $0 == name }
                                        tagColor.removeAll { $0 == color}
                                    } else {
                                        tagName.append(name)
                                        tagColor.append(color)
                                    }
                                    print(name)
                                    print(color)
                                }
                                
                            } label: {
                                ZStack {
                                    if let name = bTag.name, let color = bTag.color {
                                        Text(name)
                                            .modifier(BaseTagViewModfier(bTagColor: bTag.color ?? "#000000"))
                                        
                                        
                                        // Tag가 선택된 경우
                                        if tagName.contains(name), tagColor.contains(color) {
                                            Text(name)
                                                .modifier(clickedTagViewModfier())
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // MARK: - Grid Or ListView
                if isGridView {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(filteredFriends, id: \.self) { friend in
                                NavigationLink {
                                    SaveBdayView(bFriend: friend)
                                } label: {
                                    VStack {
                                        if let imageData = friend.profileImage, let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 150, height: 150)
                                                .clipShape(getRandomShape())
                                        } else {
                                            Image("photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 166, height: 166)
                                                .clipShape(getRandomShape())
                                        }
                                        
                                        HStack() {
                                            Spacer()
                                            VStack(alignment: .trailing) {
                                                Text(friend.name ?? "")
                                                    .foregroundStyle(.black)
                                                    .font(.biRTH_semibold_18)
                                                // TODO: iOS18에서는 ddayText 가 나타나지 않음 이전 버전에서는 확인되고 있음, 브레이크 포인트에는 걸림 하지만 background에도 안 걸림
                                                Text(dDaytext(bFriend: friend))
                                                    .foregroundStyle(Color.biRTH_text1)
                                                    .font(.biRTH_regular_12)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    List(filteredFriends, id: \.self) { friend in
                        NavigationLink {
                            SaveBdayView(bFriend: friend)
                        } label: {
                            HStack {
                                Group {
                                    if let imageData = friend.profileImage,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 45, height: 45)
                                            .clipShape(.circle)
                                    } else {
                                        Image("photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 45, height: 45)
                                            .clipShape(.circle)
                                    }
                                }
                                
                                Text(friend.name ?? "")
                                    .font(.biRTH_semibold_14)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                // TODO: iOS18에서는 ddayText 가 나타나지 않음 이전 버전에서는 확인되고 있음, 브레이크 포인트에는 걸림 하지만 background에도 안 걸림
                                Text(dDaytext(bFriend: friend))
                                    .font(.biRTH_bold_12)
                                    .foregroundColor(.biRTH_text1)
                                    .background(
                                        .red
                                    )
                                
                            } //: HSTACK
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                viewContext.delete(friend)
                                saveData(viewContext: viewContext)
                            } label: {
                                Label("Delete", systemImage: "minus.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .background(Color.red)
                            }
                            .tint(.biRTH_mainColor)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.biRTH_mainColor)
                    }
                    .listRowInsets(.none)
                    .listStyle(.plain)
                    .background(Color.biRTH_mainColor)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            .background(Color.biRTH_mainColor)
            
        }
        
    }
}


// MARK: - Temp_SearchBarForFriendListView
struct Temp_SearchBarForFriendListView: View {
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



// MARK: - ViewModifier
struct BaseTagViewModfier: ViewModifier {
    var bTagColor: String
    
    func body(content: Content) -> some View {
        content
            .font(.biRTH_semibold_14)
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 90)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 90)
                    .strokeBorder(Color.init(hex: bTagColor))
            )
        
    }
}

struct clickedTagViewModfier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.biRTH_semibold_14)
            .foregroundColor(.clear)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(.black)
            .cornerRadius(20)
            .opacity(0.15)
        
        Image(systemName: "checkmark")
            .font(.system(size: 14.5, weight: .bold))
            .foregroundColor(.white)
    }
}



// MARK: - Extension
extension Temp_FriendListView {
    func getRandomShape() -> AnyShape {
        let shapes: [AnyShape] = [
            AnyShape(CustomRectangle1()),
            AnyShape(CustomRectangle2())
        ]
        return shapes.randomElement() ?? AnyShape(CustomRectangle1())
    }
    
    func dDaytext(bFriend: BFriend) -> String {
        guard let birthdate = bFriend.birth else {
            return "저장된 날짜가 없습니다"
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let currentYear = calendar.component(.year, from: today)
        
        // 현재 연도로 생일 설정
        guard let thisYearBirthday = calendar.date(bySetting: .year, value: currentYear, of: birthdate) else {
            return "날짜 계산 오류"
        }
        
        // 오늘과 생일의 날짜 차이 계산
        let daysUntil = calendar.dateComponents([.day], from: today, to: thisYearBirthday).day ?? 0
        
        if daysUntil == 0 {
            print("birthdate(디데이): \(birthdate)")
            print("daysUntil(디데이): \(daysUntil)")
            return "D-day" // 오늘이 생일인 경우
        } else if daysUntil > 0 {
            if daysUntil <= 30 {
                print("birthdate(30일 이전): \(birthdate)")
                print("daysUntil(30일 이전): \(daysUntil)")
                return "D-\(daysUntil)"
            } else {
                print("birthdate(30일 이후): \(birthdate)")
                print("daysUntil(30일 이후): \(daysUntil)")
                return ""
            }
        } else {
            // 생일이 이미 지난 경우, 다음 해 생일 계산
            guard let nextYearBirthday = calendar.date(bySetting: .year, value: currentYear + 1, of: birthdate) else {
                return "날짜 계산 오류"
            }
            
            let nextDaysUntil = calendar.dateComponents([.day], from: today, to: nextYearBirthday).day ?? 0
            
            if nextDaysUntil <= 15 {
                print("birthdate(15일 이내): \(birthdate)")
                print("nextDaysUntil(15일 이내): \(nextDaysUntil)")
                return "D+\(nextDaysUntil)" // 15일 이내
            } else {
                print("birthdate(15일 이상): \(birthdate)")
                print("nextDaysUntil(15일 이상): \(nextDaysUntil)")
                return ""
            }
        }
    }
    
    func applySortingMethod() {
        if sortingMethod == "생일 가까운 순" {
            bFriend.sortDescriptors = [SortDescriptor(\BFriend.birth, order: .forward)]
        } else if sortingMethod == "이름 순" {
            bFriend.sortDescriptors = [SortDescriptor(\BFriend.name, order: .forward)]
        }
    }
    
}


#Preview {
    Temp_FriendListView()
}
