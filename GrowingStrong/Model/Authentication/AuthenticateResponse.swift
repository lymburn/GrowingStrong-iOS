//
//  AuthenticateResponse.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct AuthenticateResponse: Codable {
    let token: String
    let user: User 
}
