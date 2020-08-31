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
        let userAccountInfo = UserAccountInfo(email: invalidEmail, password: password)
        let userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: Date(), sex: "Male", height: 180, weight: 140, activityLevel: ActivityLevel.moderate.rawValue, weightGoalTimeline: WeightGoalTimeline.maintainWeight.rawValue)
        
        let registerRequest = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
        registrationNetworkHelperNoError.register(registerRequest: registerRequest) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.invalidEmailFormat)
        }
    }
    
    func testRegisterWithInvalidPassword() throws {
        let invalidEmail = "test123@gmail.com"
        let password = "Password1"
        let userAccountInfo = UserAccountInfo(email: invalidEmail, password: password)
        let userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: Date(), sex: "Male", height: 180, weight: 140, activityLevel: ActivityLevel.moderate.rawValue, weightGoalTimeline: WeightGoalTimeline.maintainWeight.rawValue)
        
        let registerRequest = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
        registrationNetworkHelperNoError.register(registerRequest: registerRequest) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.invalidPasswordFormat)
        }
    }
    
    func testRegisterWithNetworkError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        
        let userAccountInfo = UserAccountInfo(email: email, password: password)
        let userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: Date(), sex: "Male", height: 180, weight: 140, activityLevel: ActivityLevel.moderate.rawValue, weightGoalTimeline: WeightGoalTimeline.maintainWeight.rawValue)
        
        let registerRequest = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
        
        registrationNetworkHelperNetworkError.register(registerRequest: registerRequest) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.networkError)
        }
    }
    
    func testRegisterWithExistingUserError() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        
        let userAccountInfo = UserAccountInfo(email: email, password: password)
        let userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: Date(), sex: "Male", height: 180, weight: 140, activityLevel: ActivityLevel.moderate.rawValue, weightGoalTimeline: WeightGoalTimeline.maintainWeight.rawValue)
        
        let registerRequest = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
        
        registrationNetworkHelperUserExistsError.register(registerRequest: registerRequest) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.userAlreadyExists)
        }
    }
    
    func testRegisterSuccess() throws {
        let email = "test123@gmail.com"
        let password = "Password@123"
        
        let userAccountInfo = UserAccountInfo(email: email, password: password)
        let userProfileAndTargetsInfo = UserProfileAndTargetsInfo(birthDate: Date(), sex: "Male", height: 180, weight: 140, activityLevel: ActivityLevel.moderate.rawValue, weightGoalTimeline: WeightGoalTimeline.maintainWeight.rawValue)
        
        let registerRequest = RegisterRequest(userAccountInfo: userAccountInfo, userProfileAndTargetsInfo: userProfileAndTargetsInfo)
        
        registrationNetworkHelperNoError.register(registerRequest: registerRequest) { response, userId in
            XCTAssertEqual(response, RegistrationNetworkHelperResponse.success)
        }
    }
}
