//
//  RegisterRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct RegisterRequest: RequestModel {
    let email: String
    let password: String
    
    func generateParameters() -> Parameters {
        let parameters = ["EmailAddress" : email, "Password" : password]
        return parameters
    }
}
