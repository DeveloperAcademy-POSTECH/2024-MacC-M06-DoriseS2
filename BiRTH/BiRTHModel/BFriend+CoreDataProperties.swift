//
//  BFriend+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension BFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BFriend> {
        return NSFetchRequest<BFriend>(entityName: "BFriend")
    }

    @NSManaged public var birth: Date?
    @NSManaged public var history: [BHistory]?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var noti: [String]?
    @NSManaged public var profileImage: Data?
    @NSManaged public var tags: [String]?
    @NSManaged public var birthMonth: Int16
    @NSManaged public var birthDay: Int16
    @NSManaged public var bHistory: NSSet?
    @NSManaged public var group: GroupForBCollageAndBFriend?

}

// MARK: Generated accessors for bHistory
extension BFriend {

    @objc(addBHistoryObject:)
    @NSManaged public func addToBHistory(_ value: BHistory)

    @objc(removeBHistoryObject:)
    @NSManaged public func removeFromBHistory(_ value: BHistory)

    @objc(addBHistory:)
    @NSManaged public func addToBHistory(_ values: NSSet)

    @objc(removeBHistory:)
    @NSManaged public func removeFromBHistory(_ values: NSSet)

}

extension BFriend : Identifiable {

}
