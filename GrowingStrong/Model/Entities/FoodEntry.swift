//
//  FoodEntry.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(FoodEntry)
class FoodEntry: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case dateAdded
        case foodEntryId
        case servingAmount
        case food
        case selectedServing
    }
    
    @NSManaged var dateAdded: String
    @NSManaged var foodEntryId: Int32
    @NSManaged var servingAmount: Float
    @NSManaged var food: Food
    @NSManaged var selectedServing: Serving
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.foodEntry.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode FoodEntry")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dateAdded = try container.decode(String.self, forKey: .dateAdded)
        self.foodEntryId = try container.decode(Int32.self, forKey: .foodEntryId)
        self.servingAmount = try container.decode(Float.self, forKey: .servingAmount)
        self.food = try container.decode(Food.self, forKey: .food)
        self.selectedServing = try container.decode(Serving.self, forKey: .selectedServing)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encode(foodEntryId, forKey: .foodEntryId)
        try container.encode(servingAmount, forKey: .servingAmount)
        try container.encode(food, forKey: .food)
        try container.encode(selectedServing, forKey: .selectedServing)
    }
}
