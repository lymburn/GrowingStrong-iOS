//
//  User.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case emailAddress
        case profile
        case targets
    }
    
    @NSManaged var userId: Int32
    @NSManaged var emailAddress: String
    @NSManaged var profile: UserProfile
    @NSManaged var targets: UserTargets

    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.user.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int32.self, forKey: .userId)
        self.emailAddress = try container.decode(String.self, forKey: .emailAddress)
        self.profile = try container.decode(UserProfile.self, forKey: .profile)
        self.targets = try container.decode(UserTargets.self, forKey: .targets)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(profile, forKey: .profile)
        try container.encode(targets, forKey: .targets)
    }
}
