//
//  AuthenticationHelperTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class AuthenticationHelperTests: XCTestCase {
    let mockNoErrorUserNetworkManager = MockNoErrorUserNetworkManager()
    
    let mockErrorUserNetworkManager = MockErrorUserNetworkManager()
    
    lazy var authenticationHelperError = AuthenticationHelper(userNetworkManager: mockErrorUserNetworkManager,
                                                              jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    lazy var authenticationHelperNoError = AuthenticationHelper(userNetworkManager: mockNoErrorUserNetworkManager,
                                                                jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthenticateWithInvalidEmail() throws {
        let invalidEmail = "test123gmail.com"
        let password = "Password@1"
        authenticationHelperNoError.authenticate(email: invalidEmail, password: password) { response in
            XCTAssertEqual(response, AuthenticationHelperResponse.invalidEmailFormat)
        }
    }
    
    func testAuthenticateWithInvalidPassword() throws {
        let email = "test123@gmail.com"
        let invalidPassword = "Password1"
        authenticationHelperNoError.authenticate(email: email, password: invalidPassword) { response in
            XCTAssertEqual(response, AuthenticationHelperResponse.invalidPasswordFormat)
        }
    }
    
    func testAuthenticateWithNetworkError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        authenticationHelperError.authenticate(email: email, password: password) { response in
            XCTAssertEqual(response, AuthenticationHelperResponse.networkError)
        }
    }
    
    func testAuthenticateSuccess() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        authenticationHelperNoError.authenticate(email: email, password: password) { response in
            XCTAssertEqual(response, AuthenticationHelperResponse.success)
        }
    }
}

//Mock successfully authenticated user network manager
class MockNoErrorUserNetworkManager: UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
        
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        let response = AuthenticateResponse(token: "Token")
        completion(response, nil)
    }
}

//Mock user network manager returning error
class MockErrorUserNetworkManager: UserNetworkManagerType {
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
        
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        completion(nil, "Please check your network connection.")
    }
}