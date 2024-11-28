//
//  CoreDataController.swift
//  BiRTH
//
//  Created by Hajin on 11/21/24.
//

import CoreData

//func createBCollage(viewContext: NSManagedObjectContext, backgroundColor: String) -> BCollage {
//    let newCollage = BCollage(context: viewContext)
//    newCollage.backgroundColor = backgroundColor
//
//    saveData(viewContext: viewContext)
//    return newCollage
//}
//
//func addPhotoToCollage(viewContext: NSManagedObjectContext, collage: BCollage, image: String, posX: Double, posY: Double, scaleX: Double, scaleY: Double, rotation: Double, indexZ: Double) {
//    let newPhoto = BPhotoForCollage(context: viewContext)
//    newPhoto.id = UUID()
//    newPhoto.image = image
//    newPhoto.posX = (posX) as NSNumber
//    newPhoto.posY = (posY) as NSNumber
//    newPhoto.scaleX = (scaleX) as NSNumber
//    newPhoto.scaleY = (scaleY) as NSNumber
//    newPhoto.rotation = (rotation) as NSNumber
//    newPhoto.indexZ = (indexZ) as NSNumber
//    newPhoto.bCollage = collage 
//
//    saveData(viewContext: viewContext)
//}
//
//func fetchCollages(viewContext: NSManagedObjectContext) -> [BCollage] {
//    let fetchRequest: NSFetchRequest<BCollage> = BCollage.fetchRequest()
//    do {
//        let collages = try viewContext.fetch(fetchRequest)
//        return collages
//    } catch {
//        print("Failed to fetch collages: \(error)")
//        return []
//    }
//}

//
//func saveToCoreData(pastedImages: [PastedImage], context: NSManagedObjectContext) {
//    for pastedImage in pastedImages {
//        let newPhoto = BPhotoForCollage(context: context)
//
//        // Map properties from PastedImage to BPhotoForCollage
//        newPhoto.id = UUID() // Generate a new ID
//        newPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString() // Save as a base64 string
//        newPhoto.posX = Double(pastedImage.imagePosition.x)
//        newPhoto.posY = Double(pastedImage.imagePosition.y)
//        newPhoto.rotation = pastedImage.angleSum
//        newPhoto.scaleX = Double(pastedImage.imageWidth)
//        newPhoto.scaleY = Double(pastedImage.imageHeight)
//    }
//
//    // Save the context
//    do {
//        try context.save()
//        print("Images saved successfully to Core Data!")
//    } catch {
//        print("Error saving images to Core Data: \(error)")
//    }
//}

func updateBCollage(viewContext: NSManagedObjectContext, collage: BCollage, backgroundColor: String?) {
    if let bgColor = backgroundColor {
        collage.backgroundColor = bgColor
    }
    saveData(viewContext: viewContext)
}


func deleteBCollage(viewContext: NSManagedObjectContext, collage: BCollage) {
    viewContext.delete(collage)
    saveData(viewContext: viewContext)
}



func saveBFriend(viewContext: NSManagedObjectContext, name: String, dateOfBday: Date, notiFrequency: [String], imageData: Data? = nil, relationshipTag: [String]) {

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
func updateBFriend(viewContext: NSManagedObjectContext, bFriend: BFriend, name: String, dateOfBday: Date, notiFrequency: [String], imageData: Data? = nil, relationshipTag: [String]) {
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
//    persistenceController.container.viewContext
    saveData(viewContext: viewContext)
}


// 이걸 사용하세요!
let persistenceController = PersistenceController.shared

/// CoreData에 변경사항을 적용
func saveData(viewContext: NSManagedObjectContext) {
  do {
    try viewContext.save()
  } catch {
    let nsError = error as NSError
    fatalError("error: \(nsError), \(nsError.userInfo)")
  }
}
