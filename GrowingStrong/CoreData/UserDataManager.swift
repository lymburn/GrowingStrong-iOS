//
//  UserDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-14.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

class UserDataManager {
    let mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext
    let backgroundContext = CoreDataManager.shared.backgroundContext
    
    static let shared = UserDataManager()
    
    func createUser (userId: Int, emailAddress: String) {
        
        backgroundContext.performAndWait {
            let user = NSEntityDescription.insertNewObject(forEntityName: EntityNames.user.rawValue, into: backgroundContext) as! User
            
            user.userId = Int32(userId)
            user.emailAddress = emailAddress
            
            do {
                try backgroundContext.save()
            } catch let createError {
                print("Failed to create: \(createError)")
            }
        }
    }
    
    func fetchUser (byId userId: Int) -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: EntityNames.user.rawValue)
        let predicate = NSPredicate(format: "userId == %d", userId)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let users = try mainContext.fetch(fetchRequest)
            return users.first
        } catch let fetchError {
            print("Failed to fetch user: \(fetchError)")
        }
        
        return nil
    }
}
