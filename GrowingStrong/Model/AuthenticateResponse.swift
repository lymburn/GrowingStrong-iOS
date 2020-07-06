//
//  AuthenticateResponse.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

@objc(AuthenticateResponse)
class AuthenticateResponse: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case token
        case user
    }
    
    @NSManaged var token: String
    @NSManaged var user: User
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: EntityNames.authenticateResponse.rawValue, in: managedObjectContext)
        else {
            fatalError("Failed to decode AuthenticateResponse")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.user = try container.decode(User.self, forKey: .user)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(token, forKey: .token)
        try container.encode(user, forKey: .user)
    }
}
