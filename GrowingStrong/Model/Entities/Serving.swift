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
        case quantity
        case unit
        case kcal
        case carb
        case fat
        case protein
    }
    
    @NSManaged var servingId: Int32
    @NSManaged var quantity: Float
    @NSManaged var unit: String
    @NSManaged var kcal: Float
    @NSManaged var carb: Float
    @NSManaged var fat: Float
    @NSManaged var protein: Float

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
        self.quantity = try container.decode(Float.self, forKey: .quantity)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.kcal = try container.decode(Float.self, forKey: .kcal)
        self.carb = try container.decode(Float.self, forKey: .carb)
        self.fat = try container.decode(Float.self, forKey: .fat)
        self.protein = try container.decode(Float.self, forKey: .protein)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(servingId, forKey: .servingId)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(unit, forKey: .unit)
        try container.encode(kcal, forKey: .kcal)
        try container.encode(carb, forKey: .carb)
        try container.encode(fat, forKey: .fat)
        try container.encode(protein, forKey: .protein)
    }
}
