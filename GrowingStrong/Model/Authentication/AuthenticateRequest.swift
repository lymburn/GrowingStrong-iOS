//
//  AuthenticateRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct AuthenticateRequest: CanGenerateParameters {
    let email: String
    let password: String
    
    func generateParameters () -> Parameters {
        let parameters = ["EmailAddress" : email, "Password" : password]
        return parameters
    }
}
