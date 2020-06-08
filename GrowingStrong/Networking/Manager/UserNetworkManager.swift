//
//  UserNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

protocol UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->())
    func authenticateUser(userAuthenticationParameters: Parameters,
                          completion: @escaping (_ response: AuthenticateResponse?, _ error: String?) -> ())
}

struct UserNetworkManager {
    private let router = Router<UserApi>()
    
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->()) {
        
        router.request(.user(id: id)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
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
    
    func authenticateUser(userAuthenticationParameters: Parameters,
                          completion: @escaping (_ response: AuthenticateResponse?, _ error: String?) -> ()) {
        
        router.request(.authenticate(bodyParameters: userAuthenticationParameters)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
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
                        let authenticateResponse = try JSONDecoder().decode(AuthenticateResponse.self, from: responseData)
                        completion(authenticateResponse, nil)
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
