//
//  AuthenticationNetworkHelperTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class AuthenticationNetworkHelperTests: XCTestCase {
    let mockNoErrorUserNetworkManager = MockNoErrorUserNetworkManager()
    
    let mockNetworkErrorUserNetworkManager = MockNetworkErrorUserNetworkManager()
    
    let mockAuthenticationErrorUserNetworkManager = MockAuthenticationErrorUserNetworkManager()
    
    lazy var authenticationNetworkHelperNetworkError = AuthenticationNetworkHelper(userNetworkManager: mockNetworkErrorUserNetworkManager,
                                                                     jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    lazy var authenticationNetworkHelperAuthenticationError = AuthenticationNetworkHelper(userNetworkManager: mockAuthenticationErrorUserNetworkManager, jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    lazy var authenticationNetworkHelperNoError = AuthenticationNetworkHelper(userNetworkManager: mockNoErrorUserNetworkManager,
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
        authenticationNetworkHelperNoError.authenticate(email: invalidEmail, password: password) { response in
            XCTAssertEqual(response, AuthenticationNetworkHelperResponse.invalidEmailFormat)
        }
    }
    
    func testAuthenticateWithInvalidPassword() throws {
        let email = "test123@gmail.com"
        let invalidPassword = "Password1"
        authenticationNetworkHelperNoError.authenticate(email: email, password: invalidPassword) { response in
            XCTAssertEqual(response, AuthenticationNetworkHelperResponse.invalidPasswordFormat)
        }
    }
    
    func testAuthenticateWithNetworkError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        authenticationNetworkHelperNetworkError.authenticate(email: email, password: password) { response in
            XCTAssertEqual(response, AuthenticationNetworkHelperResponse.networkError)
        }
    }
    
    func testAuthenticateWithAuthenticationError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        authenticationNetworkHelperAuthenticationError.authenticate(email: email, password: password) { response in
            XCTAssertEqual(response, AuthenticationNetworkHelperResponse.authenticationError)
        }
    }
    
    func testAuthenticateSuccess() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        authenticationNetworkHelperNoError.authenticate(email: email, password: password) { response in
            XCTAssertEqual(response, AuthenticationNetworkHelperResponse.success)
        }
    }
}

//Mock successfully authenticated user network manager
class MockNoErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
        
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        let response = AuthenticateResponse(token: "Token")
        completion(response, nil)
    }
}

//Mock user network manager returning general network error
class MockNetworkErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
        
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        completion(nil, NetworkResponse.generalError.rawValue)
    }
}

//Mock user network manager returning general network error
class MockAuthenticationErrorUserNetworkManager: UserNetworkManagerType {
    func registerUser(registrationParameters: Parameters, completion: @escaping (RegisterResponse?, String?) -> ()) {
        
    }
    
    func getUser(id: Int, completion: @escaping (User?, String?) -> ()) {
        
    }
    
    func authenticateUser(userAuthenticationParameters: Parameters, completion: @escaping (AuthenticateResponse?, String?) -> ()) {
        completion(nil, NetworkResponse.authenticationError.rawValue)
    }
}
