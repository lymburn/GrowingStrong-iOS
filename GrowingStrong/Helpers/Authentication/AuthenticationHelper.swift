//
//  AuthenticationHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

enum AuthenticationHelperResponse {
    case success
    case invalidEmailFormat
    case invalidPasswordFormat
    case savingTokenError
    case authenticationError
    case networkError
}

struct AuthenticationHelper {
    let userNetworkManager: UserNetworkManagerType
    let jwtTokenKey: String
    
    init(userNetworkManager: UserNetworkManagerType, jwtTokenKey: String) {
        self.userNetworkManager = userNetworkManager
        self.jwtTokenKey = jwtTokenKey
    }
    
    func authenticate(email: String,
                      password: String,
                      completion: @escaping (_ response: AuthenticationHelperResponse) -> ()) {
        
        let isValidEmail = AuthenticationFormatChecker.isValidEmail(email)
        let isValidPassword = AuthenticationFormatChecker.isValidPassword(password)

        if !isValidEmail {
            return completion(.invalidEmailFormat)
        }
        
        if !isValidPassword {
            return completion(.invalidPasswordFormat)
        }
        
        let authenticateRequest = AuthenticateRequest(email: email, password: password)
        let params = authenticateRequest.generateParameters()
        
        userNetworkManager.authenticateUser(userAuthenticationParameters: params) {authenticateResponse, error in
            if let error = error {
                print(error)
                if (error == NetworkResponse.authenticationError.rawValue) {
                    completion(.authenticationError)
                } else {
                    completion(.networkError)
                }
            }

            if let response = authenticateResponse {
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
