//
//  UserTargets.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(UserTargets)
class UserTargets: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case goalWeight
        case weightGoalTimeline
    }
    
    @NSManaged var goalWeight: Float
    @NSManaged var weightGoalTimeline: String
    @NSManaged var user: User?

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.userTargets.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.goalWeight = try container.decode(Float.self, forKey: .goalWeight)
        self.weightGoalTimeline = try container.decode(String.self, forKey: .weightGoalTimeline)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(goalWeight, forKey: .goalWeight)
        try container.encode(weightGoalTimeline, forKey: .weightGoalTimeline)
    }
}
