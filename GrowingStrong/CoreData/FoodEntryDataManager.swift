//
//  FoodEntryDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import CoreData

class FoodEntryDataManager {
    
    static let shared = FoodEntryDataManager()
    
    let mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext
    let backgroundContext = CoreDataManager.shared.backgroundContext
    
    func createFoodEntry (foodEntryId: UUID,
                          food: Food,
                          dateAdded: Date,
                          servingAmount: Float,
                          selectedServing: Serving) {
        
        backgroundContext.performAndWait {
            let foodEntry = NSEntityDescription.insertNewObject(forEntityName: EntityNames.foodEntry.rawValue, into: backgroundContext) as! FoodEntry
            
            if let foodInContext = try? backgroundContext.existingObject(with: food.objectID) as? Food,
                let selectedServingInContext = try? backgroundContext.existingObject(with: selectedServing.objectID) as? Serving {
                
                foodEntry.foodEntryId = foodEntryId
                foodEntry.food = foodInContext
                foodEntry.food.foodEntry = foodEntry
                foodEntry.dateAdded = dateAdded
                foodEntry.servingAmount = servingAmount
                foodEntry.selectedServing = selectedServingInContext
                
                do {
                    try backgroundContext.save()
                } catch let createError {
                    print("Failed to create: \(createError)")
                }
            }
        }
    }
    
    func fetchFoodEntries () -> [FoodEntry]? {
        let fetchRequest = NSFetchRequest<FoodEntry>(entityName: EntityNames.foodEntry.rawValue)

        do {
            let foodEntries = try mainContext.fetch(fetchRequest)
            return foodEntries
        } catch let fetchError {
            print("Failed to fetch food entries: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchFoodEntryById (_ foodEntryId: UUID) -> FoodEntry? {
        let fetchRequest = NSFetchRequest<FoodEntry>(entityName: EntityNames.foodEntry.rawValue)
        
        let predicate = NSPredicate(format: "foodEntryId == %@", foodEntryId as CVarArg)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let foodEntries = try mainContext.fetch(fetchRequest)
            return foodEntries.first
        } catch let fetchError {
            print("Failed to fetch food entry: \(fetchError)")
        }
        
        return nil
    }
    
    func updateFoodEntryServingSize (_ foodEntryId: UUID, servingAmount: Float, selectedServing: Serving) {
        let foodEntry = fetchFoodEntryById(foodEntryId)
        let foodEntryObjId = foodEntry?.objectID
        
        backgroundContext.performAndWait {
            if let foodEntryObjId = foodEntryObjId {
                if let foodEntryInContext = try? backgroundContext.existingObject(with: foodEntryObjId) as? FoodEntry,
                    let selectedServingInContext = try? backgroundContext.existingObject(with: selectedServing.objectID) as? Serving {
                    foodEntryInContext.servingAmount = servingAmount
                    foodEntryInContext.selectedServing = selectedServingInContext
                    
                    do {
                        try backgroundContext.save()
                    } catch let updateError {
                        print("Failed to update food entry: \(updateError)")
                    }
                }
            }
        }
    }
    
    func deleteFoodEntry (foodEntryId: UUID) {
        let foodEntry = fetchFoodEntryById(foodEntryId)
        let foodEntryObjId = foodEntry?.objectID
        
        backgroundContext.performAndWait {
            if let foodEntryObjId = foodEntryObjId {
                if let foodEntryInContext = try? backgroundContext.existingObject(with: foodEntryObjId) {
                    do {
                        backgroundContext.delete(foodEntryInContext)
                        try backgroundContext.save()
                    } catch let deleteError {
                        print("Failed to delete food entry: \(deleteError)")
                    }
                }
            }
        }
    }
}
