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
        case foodName
        case foodEntries
        case servings
    }
    
    @NSManaged var foodId: Int32
    @NSManaged var foodName: String
    @NSManaged var servings: Set<Serving>

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
        self.foodName = try container.decode(String.self, forKey: .foodName)
        self.servings  = try container.decode(Set<Serving>.self, forKey: .servings)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(foodId, forKey: .foodId)
        try container.encode(foodName, forKey: .foodName)
        try container.encode(servings, forKey: .servings)
    }
}
