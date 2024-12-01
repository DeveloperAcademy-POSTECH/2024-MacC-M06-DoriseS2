//
//  BTag+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension BTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BTag> {
        return NSFetchRequest<BTag>(entityName: "BTag")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension BTag : Identifiable {

}
