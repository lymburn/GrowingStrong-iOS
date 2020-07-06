//
//  Serving.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(Serving)
class Serving: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case servingId
        case calories
        case carbohydrates
        case fat
        case protein
        case food
        case foodEntries
        case servingSize
    }
    
    @NSManaged var servingId: Int32
    @NSManaged var calories: Float
    @NSManaged var carbohydrates: Float
    @NSManaged var fat: Float
    @NSManaged var protein: Float
    @NSManaged var food: Food
    @NSManaged var foodEntries: [FoodEntry]?
    @NSManaged var servingSize: ServingSize

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.serving.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode Serving")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.servingId = try container.decode(Int32.self, forKey: .servingId)
        self.calories = try container.decode(Float.self, forKey: .calories)
        self.carbohydrates = try container.decode(Float.self, forKey: .carbohydrates)
        self.fat = try container.decode(Float.self, forKey: .fat)
        self.protein = try container.decode(Float.self, forKey: .protein)
        self.food = try container.decode(Food.self, forKey: .food)
        self.foodEntries = try container.decode([FoodEntry]?.self, forKey: .foodEntries)
        self.servingSize = try container.decode(ServingSize.self, forKey: .servingSize)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(servingId, forKey: .servingId)
        try container.encode(calories, forKey: .calories)
        try container.encode(carbohydrates, forKey: .carbohydrates)
        try container.encode(fat, forKey: .fat)
        try container.encode(protein, forKey: .protein)
        try container.encode(food, forKey: .food)
        try container.encode(foodEntries, forKey: .foodEntries)
        try container.encode(servingSize, forKey: .servingSize)
    }
}
