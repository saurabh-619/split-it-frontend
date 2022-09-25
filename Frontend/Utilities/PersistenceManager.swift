//
//  PersistenceManager.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import Foundation
import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    
    let container: NSPersistentContainer
    let containerName = "Stash"
    
    private init() {
        self.container = NSPersistentContainer(name: self.containerName)
        self.container.loadPersistentStores { _, error in
            if let error {
                print("error in loading core data - ", error.localizedDescription)
            }
        }
    }
    
    var context: NSManagedObjectContext {
        self.container.viewContext
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("error in saving the core data context - ", error.localizedDescription)
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        let context = container.viewContext
        context.delete(object)
        save()
    }
}
