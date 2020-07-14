//
//  RegisterResponse.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct RegisterResponse: Codable {
    let token: String
    let user: User
}
