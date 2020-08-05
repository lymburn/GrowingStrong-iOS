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
    
    func fetchUserProfile(_ userId: Int) -> UserProfile? {
        let predicate = NSPredicate(format: "user.userId == %d", userId)
        let profileFetch = NSFetchRequest<UserProfile>(entityName: EntityNames.userProfile.rawValue)
        profileFetch.predicate = predicate
        profileFetch.fetchLimit = 1
        
        do {
            let profiles = try mainContext.fetch(profileFetch)
            return profiles.first
        } catch let fetchError {
            print("Failed to fetch user profile: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchUserTargets(_ userId: Int) -> UserTargets? {
        let predicate = NSPredicate(format: "user.userId == %d", userId)
        let targetsFetch = NSFetchRequest<UserTargets>(entityName: EntityNames.userTargets.rawValue)
        targetsFetch.predicate = predicate
        targetsFetch.fetchLimit = 1
        
        do {
            let targets = try mainContext.fetch(targetsFetch)
            return targets.first
        } catch let fetchError {
            print("Failed to fetch user targets: \(fetchError)")
        }
        
        return nil
    }
    
    func updateUserProfile(_ userId: Int,
                           birthDate: Date?,
                           sex: String?,
                           weight: Float?,
                           height: Float?,
                           activityLevel: String?) {
        
        let fetchedProfile = fetchUserProfile(userId)
        let profileObjId = fetchedProfile?.objectID
        
        backgroundContext.performAndWait {
            if let profileObjId = profileObjId {
                if let profileInContext = try? backgroundContext.existingObject(with: profileObjId) as? UserProfile {
                    
                    profileInContext.activityLevel = activityLevel ?? profileInContext.activityLevel
                    profileInContext.birthDate = birthDate ?? profileInContext.birthDate
                    profileInContext.weight = weight ?? profileInContext.weight
                    profileInContext.height = height ?? profileInContext.height
                    profileInContext.sex = sex ?? profileInContext.sex
                    
                    let bmr = UserProfileCalculator.calculateBMR(sex: profileInContext.sex,
                                                                 weight: profileInContext.weight,
                                                                 height: profileInContext.height,
                                                                 age: profileInContext.birthDate.age)
                    
                    let tdee = UserProfileCalculator.calculateTdee(bmr: bmr, activityLevel: profileInContext.activityLevel)
                    profileInContext.bmr = bmr
                    profileInContext.tdee = tdee
                    
                    do {
                        try backgroundContext.save()
                    } catch let updateError {
                        print("Failed to update user profile: \(updateError)")
                    }
                }
            }
        }
    }
    
    func updateUserTargets(_ userId: Int, goalWeight: Float?, weightGoalTimeline: String?) {
        let fetchedTargets = fetchUserTargets(userId)
        let targetsObjId = fetchedTargets?.objectID
        
        backgroundContext.performAndWait {
            if let targetsObjId = targetsObjId {
                if let targetsInContext = try? backgroundContext.existingObject(with: targetsObjId) as? UserTargets {
                
                    targetsInContext.goalWeight = goalWeight ?? targetsInContext.goalWeight
                    targetsInContext.weightGoalTimeline = weightGoalTimeline ?? targetsInContext.weightGoalTimeline
                    
                    do {
                        try backgroundContext.save()
                    } catch let updateError {
                        print("Failed to update user targets: \(updateError)")
                    }
                }
            }
        }
    }
}
