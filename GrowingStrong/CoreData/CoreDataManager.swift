//
//  CoreDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        return context
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: CoreDataConstants.dataModelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
}
