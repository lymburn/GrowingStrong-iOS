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
    func register(registerRequest: RegisterRequest,
                  completion: @escaping (_ response: RegistrationNetworkHelperResponse, _ user: User?) -> ())
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
    
    func register(registerRequest: RegisterRequest,
                  completion: @escaping (_ response: RegistrationNetworkHelperResponse, _ user: User?) -> ()) {
        
        let isValidEmail = CredentialsFormatChecker.isValidEmail(registerRequest.email)
        let isValidPassword = CredentialsFormatChecker.isValidPassword(registerRequest.password)

        if !isValidEmail {
            return completion(.invalidEmailFormat, nil)
        }
        
        if !isValidPassword {
            return completion(.invalidPasswordFormat, nil)
        }
        let params = registerRequest.generateParameters()
        
        userNetworkManager.registerUser(registrationParameters: params) {registerResponse, error in
            if let error = error {
                print(error)
                if (error == UserNetworkResponseError.userAlreadyExists.rawValue) {
                    completion(.userAlreadyExists, nil)
                } else {
                    completion(.networkError, nil)
                }
            }

            if let response = registerResponse {
                let savedToKeyChainSuccessfully = KeychainWrapper.standard.set (response.token, forKey: self.jwtTokenKey)
                
                if !savedToKeyChainSuccessfully {
                    completion(.savingTokenError, nil)
                } else {
                    completion(.success, response.user)
                }
            }
        }
    }
}
