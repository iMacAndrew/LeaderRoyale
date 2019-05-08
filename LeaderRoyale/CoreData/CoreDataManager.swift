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
    private(set) var clans: [Clan] = []

    static let shared = CoreDataManager()

    private init() {
        do {
            let coreDataClans = try CoreDataStack.context.fetch(CoreDataClan.fetchRequest()) as [CoreDataClan]
            self.coreDataClans = coreDataClans
            for coreDataClan in coreDataClans {
                if let clan = try? JSONDecoder().decode(Clan.self, from: coreDataClan.data) {
                    clans.append(clan)
                }
            }

        } catch let e as NSError {
            assertionFailure("Error loading clans from Core Data \(e)")
        }
    }

    func isNew(clan: Clan) -> Bool {
        for otherClan in clans {
            if clan.clanInfo.tag == otherClan.clanInfo.tag {
                return false
            }
        }

        return true
    }

    func save(clan: Clan) {
        guard isNew(clan: clan) else {
            overwrite(clan: clan)
            return
        }

        guard let data = try? JSONEncoder().encode(clan) else {
            assertionFailure("Failed to encode clan.")
            return
        }

        let coreDataClanEntity = NSEntityDescription.entity(forEntityName: "CoreDataClan", in: CoreDataStack.context)!
        let coreDataClan = NSManagedObject(entity: coreDataClanEntity, insertInto: CoreDataStack.context) as! CoreDataClan
        coreDataClan.data = data
        coreDataClans.append(coreDataClan)
        clans.append(clan)
        CoreDataStack.saveContext()
    }

    private func overwrite(clan: Clan) {
        // Look through the coreDataClans for a `CoreDataClan` that has the same tag as the given `Clan`
        for coreDataClan in coreDataClans {
            if let otherClan = try? JSONDecoder().decode(Clan.self, from: coreDataClan.data),
                clan.clanInfo.tag == otherClan.clanInfo.tag {

                // We found a `CoreDataClan` that matches the `Clan`!
                // So overrite the data...
                if let newData = try? JSONEncoder().encode(clan) {
                    coreDataClan.data = newData
                } else {
                    assertionFailure("Unable to encode a clan?")
                }
            }
        }

        for i in 0..<clans.count {
            if clans[i].clanInfo.tag == clan.clanInfo.tag {
                clans[i] = clan
                break
            }
        }

        CoreDataStack.saveContext()
    }

    func delete(clanTag: String) {
        guard let indexOfClan = clans.firstIndex(where: { clan in
            clan.clanInfo.tag == clanTag
        }) else {
            return
        }

        clans.remove(at: indexOfClan)

        guard let indexOfData = coreDataClans.firstIndex(where: { coreDataClan in
            if let clan = try? JSONDecoder().decode(Clan.self, from: coreDataClan.data),
                clan.clanInfo.tag == clanTag {
                return true
            } else {
                return false
            }
        }) else {
            return
        }

        CoreDataStack.context.delete(coreDataClans[indexOfData])
        coreDataClans.remove(at: indexOfData)
        CoreDataStack.saveContext()
    }


    func isPlayerFlagged(playerTag: String) -> Bool {
        return loadFlag(playerTag: playerTag)?.isFlagged ?? false
    }

    func toggleFlag(playerTag: String) {
        defer {
            CoreDataStack.saveContext()
        }

        guard let flag = loadFlag(playerTag: playerTag) else {
            let newFlag = createFlag(playerTag: playerTag)
            newFlag.isFlagged = true
            return
        }

        flag.isFlagged = !flag.isFlagged
        
    }

    private func loadFlag(playerTag: String) -> ClanFlag? {
        do {
            let request: NSFetchRequest<ClanFlag> = ClanFlag.fetchRequest()
            request.predicate = NSPredicate(format: "playerTag = %@", playerTag)
            let flags = try CoreDataStack.context.fetch(request) as [ClanFlag]
            return flags.first
        } catch let e as NSError {
            assertionFailure("Error loading clans from Core Data \(e)")
            return nil
        }
    }

    private func createFlag(playerTag: String) -> ClanFlag {
        let clanFlagEntity = NSEntityDescription.entity(forEntityName: "ClanFlag", in: CoreDataStack.context)!
        let clanFlag = NSManagedObject(entity: clanFlagEntity, insertInto: CoreDataStack.context) as! ClanFlag
        return clanFlag
    }

}
