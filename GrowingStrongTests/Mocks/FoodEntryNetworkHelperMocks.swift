//
//  FoodEntryNetworkHelperMocks.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
@testable import GrowingStrong

class MockFoodEntryNetworkHelperNoError : FoodEntryNetworkHelperType {
    func updateFoodEntry(foodEntryId: UUID, bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (FoodEntryNetworkHelperResponse) -> ()) {
        completion(.success)
    }
    
    func deleteFoodEntry(foodEntryId: UUID, headers: HTTPHeaders, completion: @escaping (FoodEntryNetworkHelperResponse) -> ()) {
        completion(.success)
    }
    
    func createFoodEntry(bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (FoodEntryNetworkHelperResponse) -> ()) {
        completion(.success)
    }
}
