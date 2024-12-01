//
//  BPhotoForCollage+CoreDataProperties.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//
//

import Foundation
import CoreData


extension BPhotoForCollage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPhotoForCollage> {
        return NSFetchRequest<BPhotoForCollage>(entityName: "BPhotoForCollage")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var indexZ: NSNumber?
    @NSManaged public var posX: NSNumber?
    @NSManaged public var posY: NSNumber?
    @NSManaged public var rotation: NSNumber?
    @NSManaged public var scaleX: NSNumber?
    @NSManaged public var scaleY: NSNumber?
    @NSManaged public var bCollage: BCollage?

}

extension BPhotoForCollage : Identifiable {

}
