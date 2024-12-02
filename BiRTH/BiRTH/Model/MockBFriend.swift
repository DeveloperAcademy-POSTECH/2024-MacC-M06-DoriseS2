//
//  MockData.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/26/24.
//

import Foundation

// MockBFriend.swift

// MARK: - Protocol
protocol MockBFriendProtocol {
    var id: UUID { get }
    var name: String { get set }
    var birth: Date { get set }
    var profileImage: Data? { get set }
    var noti: [String] { get set }
    var tags: [String] { get set }
    var history: [BHistory] { get set }
}

// MARK: - Mock Implementation
class MockBFriend: MockBFriendProtocol {
    var id: UUID
    var name: String
    var birth: Date
    var profileImage: Data?
    var noti: [String]
    var tags: [String]
    var history: [BHistory]
    
    init(id: UUID = UUID(),
         name: String,
         birth: Date,
         profileImage: Data? = nil,
         noti: [String] = [],
         tags: [String] = [],
         history: [BHistory] = []) {
        self.id = id
        self.name = name
        self.birth = birth
        self.profileImage = profileImage
        self.noti = noti
        self.tags = tags
        self.history = history
    }
}

// MARK: - Sample Data Helper
extension MockBFriend {
    static func createSampleData() -> [MockBFriend] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        return [
            MockBFriend(
                name: "김철수",
                birth: calendar.date(byAdding: .day, value: 1, to: currentDate)!,
                noti: ["당일", "1일 전"],
                tags: ["친구", "학교"]
            ),
            MockBFriend(
                name: "이영희",
                birth: calendar.date(byAdding: .day, value: 7, to: currentDate)!,
                noti: ["3일 전"],
                tags: ["직장", "동호회"]
            )
        ]
    }
}
