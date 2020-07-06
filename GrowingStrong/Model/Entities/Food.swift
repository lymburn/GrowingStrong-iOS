//
//  Food.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(Food)
class Food: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case foodId
        case name
        case foodEntries
        case servings
    }
    
    @NSManaged var foodId: Int32
    @NSManaged var name: String
    @NSManaged var foodEntries: [FoodEntry]?
    @NSManaged var servings: [Serving]

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.food.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode Food")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.foodId = try container.decode(Int32.self, forKey: .foodId)
        self.name = try container.decode(String.self, forKey: .name)
        self.foodEntries = try container.decode([FoodEntry]?.self, forKey: .foodEntries)
        self.servings = try container.decode([Serving].self, forKey: .servings)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(foodId, forKey: .foodId)
        try container.encode(name, forKey: .name)
        try container.encode(foodEntries, forKey: .foodEntries)
        try container.encode(servings, forKey: .servings)
    }
}
