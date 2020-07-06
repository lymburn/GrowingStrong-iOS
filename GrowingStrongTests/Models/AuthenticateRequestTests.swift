//
//  AuthenticateRequestTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class AuthenticateRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateParameters() throws {
        let email = "test@gmail.com"
        let password = "password1"
        let authenticateRequest = AuthenticateRequest(email: email, password: password)
        let parameters = authenticateRequest.generateParameters()
        
        let parametersEmail = parameters["EmailAddress"] as? String
        let parametersPassword = parameters["Password"] as? String
        
        XCTAssertNotNil(parametersEmail)
        XCTAssertNotNil(parametersPassword)
        
        XCTAssertEqual(parametersEmail!, email)
        XCTAssertEqual(parametersPassword!, password)
    }
}
