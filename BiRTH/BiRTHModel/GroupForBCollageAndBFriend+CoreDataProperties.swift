//
//  GroupForBCollageAndBFriend+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension GroupForBCollageAndBFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupForBCollageAndBFriend> {
        return NSFetchRequest<GroupForBCollageAndBFriend>(entityName: "GroupForBCollageAndBFriend")
    }

    @NSManaged public var collage: BCollage?
    @NSManaged public var friend: BFriend?
    @NSManaged public var id: UUID?
    @NSManaged public var status: Status?
    @NSManaged public var bCollage: BCollage?
    @NSManaged public var bFriend: BFriend?

}

extension GroupForBCollageAndBFriend : Identifiable {

}
