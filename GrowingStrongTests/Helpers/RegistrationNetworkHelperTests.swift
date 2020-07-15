//
//  RegistrationNetworkHelperTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class RegistrationNetworkHelperTests: XCTestCase {
    let mockNoErrorUserNetworkManager = MockNoErrorUserNetworkManager()
        
    let mockNetworkErrorUserNetworkManager = MockNetworkErrorUserNetworkManager()
    
    let mockUserExistsUserNetworkManager = MockUserExistsUserNetworkManager()
    
    
    lazy var registrationNetworkHelperNetworkError = RegistrationNetworkHelper(userNetworkManager: mockNetworkErrorUserNetworkManager,
                                                                     jwtTokenKey: KeyChainKeys.unitTestJwtToken)

    lazy var registrationNetworkHelperUserExistsError = RegistrationNetworkHelper(userNetworkManager: mockUserExistsUserNetworkManager, jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    lazy var registrationNetworkHelperNoError = RegistrationNetworkHelper(userNetworkManager: mockNoErrorUserNetworkManager,
                                                                jwtTokenKey: KeyChainKeys.unitTestJwtToken)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegisterWithInvalidEmail() throws {
        let invalidEmail = "test123gmail.com"
        let password = "Password@1"
        registrationNetworkHelperNoError.register(email: invalidEmail, password: password) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.invalidEmailFormat)
        }
    }
    
    func testRegisterWithInvalidPassword() throws {
        let email = "test123@gmail.com"
        let invalidPassword = "Password1"
        registrationNetworkHelperNoError.register(email: email, password: invalidPassword) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.invalidPasswordFormat)
        }
    }
    
    func testRegisterWithNetworkError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        registrationNetworkHelperNetworkError.register(email: email, password: password) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.networkError)
        }
    }
    
    func testRegisterWithExistingUserError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        registrationNetworkHelperUserExistsError.register(email: email, password: password) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.userAlreadyExists)
        }
    }
    
    func testRegisterSuccess() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        registrationNetworkHelperNoError.register(email: email, password: password) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.success)
        }
    }
}
