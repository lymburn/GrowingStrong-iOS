//
//  UserNetworkManagerMocks.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
@testable import GrowingStrong

//Mock successfully authenticated user network manager
class MockNoErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        let response = RegisterResponse(token: "Token", user: User())
        completion (response, nil)
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        let response = AuthenticateResponse(token: "Token")
        completion(response, nil)
    }
}

//Mock user network manager returning general network error
class MockNetworkErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        completion(nil, NetworkResponse.generalError.rawValue)
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        completion(nil, NetworkResponse.generalError.rawValue)
    }
}

//Mock user network manager returning authentication network error
class MockAuthenticationErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        completion(nil, NetworkResponse.authenticationError.rawValue)
    }
}

//Mock user network manager returning user already exists network error
class MockUserExistsUserNetworkManager: UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
    }
    
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        completion(nil, UserNetworkResponseError.userAlreadyExists.rawValue)
    }
    
    
}