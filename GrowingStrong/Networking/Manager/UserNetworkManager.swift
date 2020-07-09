//
//  UserNetworkManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import CoreData

enum UserNetworkResponseError: String {
    case userAlreadyExists = "User with this email already exists"
}

protocol UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->())
    func authenticateUser(userAuthenticationParameters: Parameters,
                          completion: @escaping (_ response: AuthenticateResponse?, _ error: String?) -> ())
    func registerUser(registrationParameters: Parameters,
                      completion: @escaping (_ response: RegisterResponse?, _ error: String?) -> ())
}

class UserNetworkManager: UserNetworkManagerType {
    private let router = Router<UserApi>()
    
    private let persistentContainer: NSPersistentContainer
    
    private lazy var managedObjectContext = self.persistentContainer.viewContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getUser(id: Int, completion: @escaping (_ user: User?, _ error: String?) ->()) {
        
        router.request(.user(id: id)) { data, response, error in
            
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
    
    func registerUser(registrationParameters: Parameters,
                      completion: @escaping (RegisterResponse?, String?) -> ()) {
        
        router.request(.register(bodyParameters: registrationParameters)) { data, response, error in
            
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
                        let registerResponse = try decoder.decode(RegisterResponse.self, from: responseData)
                        try self.managedObjectContext.save()
                        
                        completion(registerResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case.failure(let networkFailureError):
                    if response.statusCode == 409 {
                        completion(nil, UserNetworkResponseError.userAlreadyExists.rawValue)
                    } else {
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
}
