//
//  CoreDataStack'.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/10/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import CoreData

// MARK: - Core Data stack

class CoreDataStack {
    private static let groupId = "group.com.imacandrew.leaderroyale"

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LeaderRoyale")
        let directory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupId)!
        let url = directory.appendingPathComponent("SingleViewCoreData.sqlite")

        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = url

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })

        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
