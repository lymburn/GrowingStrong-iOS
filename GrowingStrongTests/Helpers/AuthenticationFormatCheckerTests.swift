//
//  AuthenticationFormatCheckerTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class AuthenticationFormatCheckerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsValidEmailSuccess() throws {
        let email = "test@gmail.com"
        let isValidEmail = AuthenticationFormatChecker.isValidEmail(email)
        
        XCTAssertTrue(isValidEmail)
    }
    
    func testIsValidEmailFailure() throws {
        let email = "testgmail.com"
        let isValidEmail = AuthenticationFormatChecker.isValidEmail(email)
        
        XCTAssertFalse(isValidEmail)
    }
    
    func testIsValidEmailSpecialChars() throws {
        let email = "1=1;@gmail.com"
        let isValidEmail = AuthenticationFormatChecker.isValidEmail(email)
        
        XCTAssertFalse(isValidEmail)
    }
    
    func testIsValidPasswordSuccess() throws {
        let password = "Password@123"
        let isValidPassword = AuthenticationFormatChecker.isValidPassword(password)
        
        XCTAssertTrue(isValidPassword)
    }
    
    func testIsValidPasswordNoSpecialChars() throws {
        let password = "password123"
        let isValidPassword = AuthenticationFormatChecker.isValidPassword(password)
        
        XCTAssertFalse(isValidPassword)
    }
    
    func testIsValidPasswordUnder6Chars() {
        let password = "pass"
        let isValidPassword = AuthenticationFormatChecker.isValidPassword(password)
        
        XCTAssertFalse(isValidPassword)
    }
}
