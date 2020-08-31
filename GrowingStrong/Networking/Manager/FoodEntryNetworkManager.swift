//
//  FoodEntryNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

protocol FoodEntryNetworkManagerType: CanReceiveNoDecodingResponses {
    func createFoodEntry(bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping ( _ error: String?) -> ())
    func updateFoodEntry(foodEntryId: UUID,
                         bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ error: String?) -> ())
    func deleteFoodEntry(foodEntryId: UUID,
                         headers: HTTPHeaders,
                         completion: @escaping (_ error: String?) -> ())
}

class FoodEntryNetworkManager: FoodEntryNetworkManagerType {
    private let router = Router<FoodEntryApi>()
    
    func createFoodEntry(bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (String?) -> ()) {
        router.request(.create(bodyParameters: bodyParameters, headers: headers)) { data, response, error in
            self.handleNoDecodingResponse(response: response, error: error, completion: completion)
        }
    }
    
    func updateFoodEntry(foodEntryId: UUID, bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (String?) -> ()) {
        router.request(.update(foodEntryId: foodEntryId, bodyParameters: bodyParameters, headers: headers)) { data, response, error in
            self.handleNoDecodingResponse(response: response, error: error, completion: completion)
        }
    }
    
    func deleteFoodEntry(foodEntryId: UUID, headers: HTTPHeaders, completion: @escaping (String?) -> ()) {
        router.request(.delete(foodEntryId: foodEntryId, headers: headers)) { data, response, error in
            self.handleNoDecodingResponse(response: response, error: error, completion: completion)
        }
    }
}
