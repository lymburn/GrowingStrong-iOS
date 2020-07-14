//
//  UserNetworkHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-13.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol UserNetworkHelperType {
    func getUserFoodEntries(userId: Int, completion: @escaping (_ response: UserNetworkHelperResponse,_ foodEntries: [FoodEntry]?) -> ())
}

enum UserNetworkHelperResponse {
    case success
    case networkError
}

struct UserNetworkHelper: UserNetworkHelperType {
    let userNetworkManager: UserNetworkManagerType
    let jwtTokenKey: String
    
    init(userNetworkManager: UserNetworkManagerType, jwtTokenKey: String) {
        self.userNetworkManager = userNetworkManager
        self.jwtTokenKey = jwtTokenKey
    }
    
    func getUserFoodEntries(userId: Int, completion: @escaping (UserNetworkHelperResponse, [FoodEntry]?) -> ()) {
        self.userNetworkManager.getUserFoodEntries(userId: userId) { foodEntries, error in
            if let error = error {
                print(error)
                completion(.networkError, nil)
            }
            
            if let foodEntries = foodEntries {
                completion(.success, foodEntries)
            }
        }
    }
}
