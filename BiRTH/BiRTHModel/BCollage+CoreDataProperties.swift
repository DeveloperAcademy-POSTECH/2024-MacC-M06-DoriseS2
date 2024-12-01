//
//  BCollage+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension BCollage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BCollage> {
        return NSFetchRequest<BCollage>(entityName: "BCollage")
    }

    @NSManaged public var backgroundColor: String?
    @NSManaged public var photos: [BPhotoForCollage]?
    @NSManaged public var bPhotoForCollage: NSSet?
    @NSManaged public var group: GroupForBCollageAndBFriend?

}

// MARK: Generated accessors for bPhotoForCollage
extension BCollage {

    @objc(addBPhotoForCollageObject:)
    @NSManaged public func addToBPhotoForCollage(_ value: BPhotoForCollage)

    @objc(removeBPhotoForCollageObject:)
    @NSManaged public func removeFromBPhotoForCollage(_ value: BPhotoForCollage)

    @objc(addBPhotoForCollage:)
    @NSManaged public func addToBPhotoForCollage(_ values: NSSet)

    @objc(removeBPhotoForCollage:)
    @NSManaged public func removeFromBPhotoForCollage(_ values: NSSet)

}

extension BCollage : Identifiable {

}
