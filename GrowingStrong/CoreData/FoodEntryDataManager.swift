//
//  FoodEntryDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import CoreData

struct FoodEntryDataManager {
    static let context: NSManagedObjectContext = CoreDataManager.shared.context
    
    @discardableResult
    static func createFoodEntry (food: Food,
                                 dateAdded: Date,
                                 servingAmount: Float,
                                 selectedServing: Serving) -> FoodEntry? {
        
        let foodEntry = NSEntityDescription.insertNewObject(forEntityName: EntityNames.foodEntry.rawValue, into: context) as! FoodEntry
        
        foodEntry.food = food
        foodEntry.dateAdded = dateAdded
        foodEntry.servingAmount = servingAmount
        foodEntry.selectedServing = selectedServing
        
        do {
            try context.save()
            return foodEntry
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    static func fetchFoodEntries () -> [FoodEntry]? {
        let fetchRequest = NSFetchRequest<FoodEntry>(entityName: EntityNames.foodEntry.rawValue)

        do {
            let foodEntries = try context.fetch(fetchRequest)
            return foodEntries
        } catch let fetchError {
            print("Failed to fetch food entries: \(fetchError)")
        }
        
        return nil
    }
    
    static func fetchFoodEntryById (_ foodEntryId: Int32) -> FoodEntry? {
        let fetchRequest = NSFetchRequest<FoodEntry>(entityName: EntityNames.foodEntry.rawValue)
        
        let predicate = NSPredicate(format: "foodEntryId == %d", foodEntryId)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let foodEntries = try context.fetch(fetchRequest)
            return foodEntries.first
        } catch let fetchError {
            print("Failed to fetch food entry: \(fetchError)")
        }
        
        return nil
    }
    
    static func updateFoodEntryServingSize (_ foodEntryId: Int32, servingAmount: Float, selectedServing: Serving) {
        let foodEntry = fetchFoodEntryById(foodEntryId)
        
        if let foodEntry = foodEntry {
            foodEntry.servingAmount = servingAmount
            foodEntry.selectedServing = selectedServing
        }
        
        do {
            try context.save()
        } catch let updateError {
            print("Failed to update food entry: \(updateError)")
        }
    }
    
    static func deleteFoodEntry (foodEntryId: Int32) {
        let foodEntry = fetchFoodEntryById(foodEntryId)
        
        if let foodEntry = foodEntry {
            context.delete(foodEntry)
        }
    }
    
    static func generateNewFoodEntryManagedObject() -> FoodEntry {
        let foodEntryEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityNames.foodEntry.rawValue,
                                                                              in: CoreDataManager.shared.context)!
        
        let foodEntry = NSManagedObject(entity: foodEntryEntity, insertInto: context) as! FoodEntry
        
        return foodEntry
    }
}
