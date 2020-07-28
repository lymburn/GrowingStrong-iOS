//
//  UserProfile.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(UserProfile)
class UserProfile: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case birthDate
        case sex
        case height
        case weight
        case bmr
        case activityLevel
        case tdee
    }
    
    @NSManaged var birthDate: Date
    @NSManaged var sex: String
    @NSManaged var height: Float
    @NSManaged var weight: Float
    @NSManaged var bmr: Float
    @NSManaged var activityLevel: String
    @NSManaged var tdee: Float
    @NSManaged var user: User?

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.userProfile.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .birthDate)
        let dateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.ISO8601)
        
        if let date = dateFormatter.date(from: dateString) {
            self.birthDate = date
        }
        
        self.sex = try container.decode(String.self, forKey: .sex)
        self.height = try container.decode(Float.self, forKey: .height)
        self.weight = try container.decode(Float.self, forKey: .weight)
        self.bmr = try container.decode(Float.self, forKey: .bmr)
        self.activityLevel = try container.decode(String.self, forKey: .activityLevel)
        self.tdee = try container.decode(Float.self, forKey: .tdee)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encode(sex, forKey: .sex)
        try container.encode(height, forKey: .height)
        try container.encode(weight, forKey: .weight)
        try container.encode(bmr, forKey: .bmr)
        try container.encode(activityLevel, forKey: .activityLevel)
        try container.encode(tdee, forKey: .tdee)
    }
}
