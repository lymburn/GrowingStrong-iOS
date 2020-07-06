//
//  ServingSize.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(ServingSize)
class ServingSize: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case quantity
        case unit
        case servings
    }
    
    @NSManaged var quantity: Float
    @NSManaged var unit: String
    @NSManaged var servings: [Serving]?

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.servingSize.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode ServingSize")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.quantity = try container.decode(Float.self, forKey: .quantity)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.servings = try container.decode([Serving].self, forKey: .servings)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(unit, forKey: .unit)
        try container.encode(servings, forKey: .servings)
    }
}
