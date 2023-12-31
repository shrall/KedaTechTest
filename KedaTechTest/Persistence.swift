//
//  Persistence.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 24/06/23.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "KedaTechTest")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        )
    }
}
