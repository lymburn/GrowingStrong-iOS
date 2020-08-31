//
//  UserNetworkHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-13.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

protocol UserNetworkHelperType {
    func getUserFoodEntries(userId: Int,
                            headers: HTTPHeaders,
                            completion: @escaping (_ response: UserNetworkHelperResponse,_ foodEntries: [FoodEntry]?) -> ())
    
    func updateUserProfile(userId: Int,
                           bodyParameters: Parameters,
                           headers: HTTPHeaders,
                           completion: @escaping (_ response: UserNetworkHelperResponse) -> ())
    
    func updateUserTargets(userId: Int,
                           bodyParameters: Parameters,
                           headers: HTTPHeaders,
                           completion: @escaping (_ response: UserNetworkHelperResponse) -> ())
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
    
    func getUserFoodEntries(userId: Int,
                            headers: HTTPHeaders,
                            completion: @escaping (UserNetworkHelperResponse, [FoodEntry]?) -> ()) {
        
        self.userNetworkManager.getUserFoodEntries(userId: userId, headers: headers) { foodEntries, error in
            if let error = error {
                print(error)
                completion(.networkError, nil)
            }
            
            if let foodEntries = foodEntries {
                completion(.success, foodEntries)
            }
        }
    }
    
    func updateUserProfile(userId: Int,
                           bodyParameters: Parameters,
                           headers: HTTPHeaders,
                           completion: @escaping (UserNetworkHelperResponse) -> ()) {
        
        self.userNetworkManager.updateUserProfile(userId: userId, bodyParameters: bodyParameters, headers: headers) { error in
            self.handleNoResponseCompletions(error: error, completion: completion)
        }
    }
    
    func updateUserTargets(userId: Int,
                           bodyParameters: Parameters,
                           headers: HTTPHeaders,
                           completion: @escaping (UserNetworkHelperResponse) -> ()) {
        self.userNetworkManager.updateUserTargets(userId: userId, bodyParameters: bodyParameters, headers: headers) { error in
            self.handleNoResponseCompletions(error: error, completion: completion)
        }
    }
    
    private func handleNoResponseCompletions(error: String?, completion: @escaping (_ response: UserNetworkHelperResponse) ->()) {
        if let error = error {
            print(error)
            completion(.networkError)
        }
        
        completion(.success)
    }
}
