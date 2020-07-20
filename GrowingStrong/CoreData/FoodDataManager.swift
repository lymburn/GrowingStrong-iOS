//
//  FoodDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import CoreData

class FoodDataManager {
    let mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext
    let backgroundContext = CoreDataManager.shared.backgroundContext
    
    static let shared = FoodDataManager()
    
    private func fetchFoodsWithoutFoodEntry() -> [Food]? {
        let fetchRequest = NSFetchRequest<Food>(entityName: EntityNames.food.rawValue)
        
        let predicate = NSPredicate(format: "\(#keyPath(Food.foodEntry)) == nil")
        fetchRequest.predicate = predicate
        
        do {
            let foods = try mainContext.fetch(fetchRequest)
            return foods
        } catch let fetchError {
            print("Failed to fetch foods: \(fetchError)")
        }
        
        return nil
    }
    
    //Delete foods without a corresponding food entry relation
    func deleteFoodsWithoutFoodEntry () {
        let foods = fetchFoodsWithoutFoodEntry()
        
        if let foods = foods {
            for food in foods {
                let foodObjId = food.objectID
                if let foodInContext = try? backgroundContext.existingObject(with: foodObjId) {
                    do {
                        backgroundContext.delete(foodInContext)
                        try backgroundContext.save()
                    } catch let deleteError {
                        print("Failed to delete food: \(deleteError)")
                    }
                }
            }
        }
    }
}

