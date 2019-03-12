//
//  CoreDataManager.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/11/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    private var coreDataClans = [CoreDataClan]()

    var clans: [Clan] {
        var clans = [Clan]()
        for coreDataClan in coreDataClans {
            if let clan = try? JSONDecoder().decode(Clan.self, from: coreDataClan.data) {
                clans.append(clan)
            }
        }
        return clans
    }

    static let shared = CoreDataManager()

    private init() {
        do {
            let coreDataClans = try CoreDataStack.context.fetch(CoreDataClan.fetchRequest()) as [CoreDataClan]
            self.coreDataClans = coreDataClans

        } catch let e as NSError {
            assertionFailure("Error loading clans from Core Data \(e)")
        }
    }

    func save(clan: Clan) {
        guard let data = try? JSONEncoder().encode(clan) else {
            assertionFailure("Failed to encode clan.")
            return
        }

        let coreDataClanEntity = NSEntityDescription.entity(forEntityName: "CoreDataClan", in: CoreDataStack.context)!
        let coreDataClan = NSManagedObject(entity: coreDataClanEntity, insertInto: CoreDataStack.context) as! CoreDataClan
        coreDataClan.data = data
        coreDataClans.append(coreDataClan)
        CoreDataStack.saveContext()
    }
}
