//
//  BHistory+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension BHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BHistory> {
        return NSFetchRequest<BHistory>(entityName: "BHistory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var photoForCollageByFriend: Data?
    @NSManaged public var photoForCollageByMyself: Data?
    @NSManaged public var year: Date?
    @NSManaged public var bFriend: BFriend?

}

extension BHistory : Identifiable {

}
