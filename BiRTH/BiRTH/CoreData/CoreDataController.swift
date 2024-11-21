//
//  CoreDataController.swift
//  BiRTH
//
//  Created by Hajin on 11/21/24.
//

import CoreData

func saveBFriend(viewContext: NSManagedObjectContext, name: String, dateOfBday: Date, isLunar: Bool, notiFrequency: [String], imageData: Data? = nil, relationshipTag: [String]) {

        let newFriend = BFriend(context: viewContext)
        newFriend.id = UUID()
        newFriend.name = name
        newFriend.birth = dateOfBday
        newFriend.noti = notiFrequency
        newFriend.profileImage = imageData
        newFriend.tags = relationshipTag

        saveData(viewContext: viewContext)

}

// BFriend update
func updateChatEnt(viewContext: NSManagedObjectContext, bFriend: BFriend, name: String, dateOfBday: Date, isLunar: Bool, notiFrequency: [String], imageData: Data, relationshipTag: [String]) {
  do {
    // NSManagedObjectID로 해당 objectID를 갖고 있는 BFriend 찾기
      if let bFriendUpdate = try viewContext.existingObject(with: bFriend.objectID) as? BFriend {
          bFriendUpdate.name = name
          bFriendUpdate.birth = dateOfBday
          bFriendUpdate.noti = notiFrequency
          bFriendUpdate.profileImage = imageData
          bFriendUpdate.tags = relationshipTag

      saveData(viewContext: viewContext)
    }
  } catch {
    let nsError = error as NSError
    fatalError("error: \(nsError), \(nsError.userInfo)")
  }
}

// BFriend delete
func deleteBFriend(viewContext: NSManagedObjectContext, bFriend: BFriend) {
  viewContext.delete(bFriend)
  saveData(viewContext: viewContext)
}

/// 전체 태그 생성 함수
func createBTag(viewContext: NSManagedObjectContext, tagName: String, tagColor: String) {
    let newBTag = BTag(context: viewContext)
    newBTag.id = UUID()
    newBTag.name = tagName
    newBTag.color = tagColor

    saveData(viewContext: viewContext)
}

/// CoreData에 변경사항을 적용
func saveData(viewContext: NSManagedObjectContext) {
  do {
    try viewContext.save()
  } catch {
    let nsError = error as NSError
    fatalError("error: \(nsError), \(nsError.userInfo)")
  }
}
