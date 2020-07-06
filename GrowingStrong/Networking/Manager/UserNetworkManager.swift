//
//  UserNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

protocol UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->())
    func authenticateUser(userAuthenticationParameters: Parameters,
                          completion: @escaping (_ response: AuthenticateResponse?, _ error: String?) -> ())
}

class UserNetworkManager {
    private let router = Router<UserApi>()
    
    private let persistentContainer: NSPersistentContainer
    
    private lazy var managedObjectContext = self.persistentContainer.viewContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->()) {
        
        router.request(.user(id: id)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
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
                        let user = try decoder.decode(User.self, from: responseData)
                        try self.managedObjectContext.save()
                        
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
                        let authenticateResponse = try decoder.decode(AuthenticateResponse.self, from: responseData)
                        try self.managedObjectContext.save()

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
