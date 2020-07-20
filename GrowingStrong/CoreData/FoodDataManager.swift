//
//  FoodDataManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import CoreData

struct FoodDataManager {
    static let context: NSManagedObjectContext = CoreDataManager.shared.context
    
    private static func fetchFoodsWithoutFoodEntry() -> [Food]? {
        let fetchRequest = NSFetchRequest<Food>(entityName: EntityNames.food.rawValue)
        
        let predicate = NSPredicate(format: "\(#keyPath(Food.foodEntry)) == nil")
        fetchRequest.predicate = predicate
        
        do {
            let foods = try context.fetch(fetchRequest)
            return foods
        } catch let fetchError {
            print("Failed to fetch foods: \(fetchError)")
        }
        
        return nil
    }
    
    //Delete foods without a corresponding food entry relation
    static func deleteFoodsWithoutFoodEntry () {
        let foods = fetchFoodsWithoutFoodEntry()
        
        if let foods = foods {
            for food in foods {
                context.delete(food)
            }
        }
    }
}

