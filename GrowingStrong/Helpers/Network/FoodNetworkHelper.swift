//
//  FoodNetworkHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation


protocol FoodNetworkHelperType {
    
    func getFoodsByFullTextSearch(urlParameters: Parameters,
                                  headers: HTTPHeaders,
                                  completion: @escaping (_ response: FoodNetworkHelperResponse, _ foods: [Food]?) -> ())
}

enum FoodNetworkHelperResponse {
    case success
    case invalidQueryText
    case networkError
}

struct FoodNetworkHelper: FoodNetworkHelperType {
    let foodNetworkManager: FoodNetworkManagerType
    let jwtTokenKey: String
    
    init(foodNetworkManager: FoodNetworkManagerType, jwtTokenKey: String) {
        self.foodNetworkManager = foodNetworkManager
        self.jwtTokenKey = jwtTokenKey
    }
    
    func getFoodsByFullTextSearch(urlParameters: Parameters,
                                  headers: HTTPHeaders,
                                  completion: @escaping (FoodNetworkHelperResponse, [Food]?) -> ()) {

        if let queryText = urlParameters["query"] as? String, !queryText.isEmpty {
            
            foodNetworkManager.getFoodsByFullTextSearch(urlParameters: urlParameters, headers: headers) { foods, error in
                if let error = error {
                    print (error)
                    completion (.networkError, nil)
                }
                
                if let foods = foods {
                    completion(.success, foods)
                }
            }
            
        } else {
            completion(.invalidQueryText, nil)
        }
    }
}
