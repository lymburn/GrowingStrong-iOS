//
//  LoginControllerTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class LoginControllerTests: XCTestCase {
    
    //typealias LoginViewType = LoginViewProtocol & UIView
    let controller: LoginController = LoginController()
    let mockLoginView: MockLoginView = MockLoginView()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller.setupLoginView(mockLoginView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
