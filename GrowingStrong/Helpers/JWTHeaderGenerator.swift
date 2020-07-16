//
//  JWTHeaderGenerator.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import SwiftKeychainWrapper

struct JWTHeaderGenerator {
    static func generateHeader(jwtTokenKey: String) -> HTTPHeaders? {
        if (KeychainWrapper.standard.hasValue(forKey: jwtTokenKey)) {
            let jwtToken = KeychainWrapper.standard.string(forKey: jwtTokenKey)
            if let jwtToken = jwtToken {
                let authorizationHeaderKey = "Authorization"
                let authorizationHeaderValue = "Bearer " + jwtToken
                
                return [authorizationHeaderKey: authorizationHeaderValue]
            }
        }
        
        return nil
    }
}
