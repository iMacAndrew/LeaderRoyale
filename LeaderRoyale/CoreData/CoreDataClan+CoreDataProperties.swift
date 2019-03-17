//
//  CoreDataClan+CoreDataProperties.swift
//  
//
//  Created by Andy Humphries on 3/10/19.
//
//

import Foundation
import CoreData


extension CoreDataClan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataClan> {
        return NSFetchRequest<CoreDataClan>(entityName: "CoreDataClan")

    }

    @NSManaged public var data: Data

}
