//
//  FoodNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

protocol FoodNetworkManagerType {
    func getFoodsByFullTextSearch(urlParameters: Parameters,
                                  headers: HTTPHeaders,
                                  completion: @escaping (_ foods: [Food]?, _ error: String?) ->())
}

class FoodNetworkManager: FoodNetworkManagerType {
    private let router = Router<FoodApi>()
    
    private let persistentContainer: NSPersistentContainer
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer, managedObjectContext: NSManagedObjectContext) {
        self.persistentContainer = persistentContainer
        self.managedObjectContext = managedObjectContext
    }
    
    func getFoodsByFullTextSearch(urlParameters: Parameters,
                                  headers: HTTPHeaders,
                                  completion: @escaping ([Food]?, String?) -> ()) {
        
        
        router.request(.getFoodsByFullTextSearch(urlParameters: urlParameters, headers: headers)) { data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.generalError.rawValue)
            }
            
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
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
                        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = self.managedObjectContext
                        let foods = try decoder.decode([Food].self, from: responseData)
                        
                        completion(foods, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case.failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}

