//
//  FoodEntryNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

protocol FoodEntryNetworkManagerType {
    func createFoodEntry(bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ createFoodEntryResponse: CreateFoodEntryResponse?, _ error: String?) -> ())
    func updateFoodEntry(foodEntryId: Int,
                         bodyParameters: Parameters,
                         headers: HTTPHeaders,
                         completion: @escaping (_ error: String?) -> ())
    func deleteFoodEntry(foodEntryId: Int,
                         headers: HTTPHeaders,
                         completion: @escaping (_ error: String?) -> ())
}

class FoodEntryNetworkManager: FoodEntryNetworkManagerType {
    private let router = Router<FoodEntryApi>()
    
    func createFoodEntry(bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (CreateFoodEntryResponse?, String?) -> ()) {
        router.request(.create(bodyParameters: bodyParameters, headers: headers)) { data, response, error in
            
            if error != nil {
                completion(nil, NetworkResponse.generalError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponseHandler.handleResponse(response)

                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let createFoodEntryResponse = try decoder.decode(CreateFoodEntryResponse.self, from: responseData)
                        
                        completion(createFoodEntryResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case.failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func updateFoodEntry(foodEntryId: Int, bodyParameters: Parameters, headers: HTTPHeaders, completion: @escaping (String?) -> ()) {
        router.request(.update(foodEntryId: foodEntryId, bodyParameters: bodyParameters, headers: headers)) { data, response, error in
            if error != nil {
                completion(NetworkResponse.generalError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponseHandler.handleResponse(response)

                switch result {
                case .success:
                    completion(nil)
                case.failure(let networkFailureError):
                    completion(networkFailureError)
                }
            }
        }
    }
    
    func deleteFoodEntry(foodEntryId: Int, headers: HTTPHeaders, completion: @escaping (String?) -> ()) {
        router.request(.delete(foodEntryId: foodEntryId, headers: headers)) { data, response, error in
            if error != nil {
                completion(NetworkResponse.generalError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponseHandler.handleResponse(response)

                switch result {
                case .success:
                    completion(nil)
                case.failure(let networkFailureError):
                    completion(networkFailureError)
                }
            }
        }
    }
}
