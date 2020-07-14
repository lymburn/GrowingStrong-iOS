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
    
    private func clearStorage(forEntity entityName: String) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try context.execute(batchDeleteRequest)
    }
    
    //Return true on success and false otherwise
    func clearAllStorage() {
        EntityNames.allCases.forEach {
            do {
                try clearStorage(forEntity: $0.rawValue)
            } catch let error {
                print (error)
            }
        }
    }
}
