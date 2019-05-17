//
//  ClanFlag+CoreDataProperties.swift
//  
//
//  Created by Andy Humphries on 3/25/19.
//
//

import Foundation
import CoreData


extension ClanFlag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClanFlag> {
        return NSFetchRequest<ClanFlag>(entityName: "ClanFlag")
    }

    @NSManaged public var isFlagged: Bool
    @NSManaged public var playerTag: String

}
