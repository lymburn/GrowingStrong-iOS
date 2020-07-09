//
//  RegistrationHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol RegistrationNetworkHelperType {
    func register(email: String, password: String, completion: @escaping (_ response: RegistrationNetworkHelperResponse) -> ())
}

enum RegistrationNetworkHelperResponse {
    case success
    case invalidEmailFormat
    case invalidPasswordFormat
    case savingTokenError
    case userAlreadyExists
    case networkError
}

struct RegistrationNetworkHelper: RegistrationNetworkHelperType {
    let userNetworkManager: UserNetworkManagerType
    let jwtTokenKey: String
    
    init(userNetworkManager: UserNetworkManagerType, jwtTokenKey: String) {
        self.userNetworkManager = userNetworkManager
        self.jwtTokenKey = jwtTokenKey
    }
    
    func register(email: String,
                      password: String,
                      completion: @escaping (_ response: RegistrationNetworkHelperResponse) -> ()) {
        
        let isValidEmail = CredentialsFormatChecker.isValidEmail(email)
        let isValidPassword = CredentialsFormatChecker.isValidPassword(password)

        if !isValidEmail {
            return completion(.invalidEmailFormat)
        }
        
        if !isValidPassword {
            return completion(.invalidPasswordFormat)
        }
        
        let registerRequest = RegisterRequest(email: email, password: password)
        let params = registerRequest.generateParameters()
        
        userNetworkManager.registerUser(registrationParameters: params) {registerResponse, error in
            if let error = error {
                print(error)
                if (error == UserNetworkResponseError.userAlreadyExists.rawValue) {
                    completion(.userAlreadyExists)
                } else {
                    completion(.networkError)
                }
            }

            if let response = registerResponse {
                let savedToKeyChainSuccessfully = KeychainWrapper.standard.set (response.token, forKey: self.jwtTokenKey)
                
                if !savedToKeyChainSuccessfully {
                    completion(.savingTokenError)
                } else {
                    completion(.success)
                }
            }
        }
    }
}
