//
//  UserDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-14.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

protocol UserDataManagerType {
    func createUser (userId: Int, emailAddress: String) -> User?
    func fetchUser (byId userId: Int) -> User?
}

struct UserDataManager: UserDataManagerType {
    let context: NSManagedObjectContext = CoreDataManager.shared.context
    
    @discardableResult
    func createUser (userId: Int,
                     emailAddress: String) -> User? {
        
        let user = NSEntityDescription.insertNewObject(forEntityName: EntityNames.user.rawValue, into: context) as! User
        
        user.userId = Int32(userId)
        user.emailAddress = emailAddress
        
        do {
            try context.save()
            return user
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func fetchUser (byId userId: Int) -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: EntityNames.user.rawValue)
        let predicate = NSPredicate(format: "userId == %d", userId)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch let fetchError {
            print("Failed to fetch user: \(fetchError)")
        }
        
        return nil
    }
}
