//
//  FoodEntryNetworkHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

protocol FoodEntryNetworkHelperType {
    func createFoodEntry(bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ response: FoodEntryNetworkHelperResponse) -> ())
    
    func updateFoodEntry(foodEntryId: Int,
                         bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ response: FoodEntryNetworkHelperResponse) -> ())
    
    func deleteFoodEntry(foodEntryId: Int,
                         headers: HTTPHeaders,
                         completion: @escaping (_ response: FoodEntryNetworkHelperResponse) -> ())
}

enum FoodEntryNetworkHelperResponse {
    case success
    case networkError
}

struct FoodEntryNetworkHelper: FoodEntryNetworkHelperType {
    
    let foodEntryNetworkManager: FoodEntryNetworkManagerType
    let jwtTokenKey: String
    
    init(foodEntryNetworkManager: FoodEntryNetworkManagerType, jwtTokenKey: String) {
        self.foodEntryNetworkManager = foodEntryNetworkManager
        self.jwtTokenKey = jwtTokenKey
    }
    
    func createFoodEntry(bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (FoodEntryNetworkHelperResponse) -> ()) {
        
        foodEntryNetworkManager.createFoodEntry(bodyParameters: bodyParameters, headers: headers) { error in
            self.handleNoResponseCompletions(error: error, completion: completion)
        }
    }
    
    func updateFoodEntry(foodEntryId: Int,
                         bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ response: FoodEntryNetworkHelperResponse) -> ()) {
        
        foodEntryNetworkManager.updateFoodEntry(foodEntryId: foodEntryId, bodyParameters: bodyParameters, headers: headers) { error in
            self.handleNoResponseCompletions(error: error, completion: completion)
        }
    }
    
    func deleteFoodEntry(foodEntryId: Int,
                     headers: HTTPHeaders,
                     completion: @escaping (_ response: FoodEntryNetworkHelperResponse) -> ()) {
        
        foodEntryNetworkManager.deleteFoodEntry(foodEntryId: foodEntryId, headers: headers) { error in
            self.handleNoResponseCompletions(error: error, completion: completion)
        }
    }
    
    private func handleNoResponseCompletions(error: String?, completion: @escaping (_ response: FoodEntryNetworkHelperResponse) ->()) {
        if let error = error {
            print(error)
            completion(.networkError)
        }
        
        completion(.success)
    }
}
