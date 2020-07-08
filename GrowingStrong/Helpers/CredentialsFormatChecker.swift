//
//  CredentialsFormatChecker.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

//Helper to check correct formats in login/registration info
struct CredentialsFormatChecker {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    //Check if password contains characters and one special characters and is minimum six char long
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
}
