import SwiftUI
//import CoreData

class FriendListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var allFriends: [BFriend] = [] // 기본값: 빈 배열

    var filteredFriends: [BFriend] {
        guard !searchText.isEmpty else { return allFriends }
        return allFriends.filter { friend in
            friend.name?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }

    // 기본값 생성자
    init(fetchedFriends: FetchedResults<BFriend>? = nil) {
        // Fetch된 값이 없으면 기본값 사용
        self.allFriends = fetchedFriends.map { Array($0) } ?? []
    }
}
