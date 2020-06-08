//
//  UserNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

class UserNetworkManager: NetworkManager {
    private let router = Router<UserApi>()
    
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->()) {
        
        router.request(.user(id: id)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let user = try JSONDecoder().decode(User.self, from: responseData)
                        completion(user, nil)
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
