//
//  LoginControllerMocks.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
@testable import GrowingStrong

class MockLoginView: LoginViewType {
    func getEmailValue() -> String {
        return ""
    }
    
    func getPasswordValue() -> String {
        return ""
    }
}
