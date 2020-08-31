//
//  UserProfileCalculatorTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-08-31.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class UserProfileCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateBMRForMale() {
        let sex = "Male"
        let weight: Float = 80
        let height: Float = 180
        let age = 20
        
        let expectedBmr = "1910.4"
        let bmr = UserProfileCalculator.calculateBMR(sex: sex, weight: weight, height: height, age: age).toOneDecimalString
        
        XCTAssertEqual(bmr, expectedBmr)
    }
    
    func testCalculateBMRForFemale() {
        let sex = "Female"
        let weight: Float = 80
        let height: Float = 180
        let age = 20
        
        let expectedBmr = "1658.4"
        let bmr = UserProfileCalculator.calculateBMR(sex: sex, weight: weight, height: height, age: age).toOneDecimalString
        
        XCTAssertEqual(bmr, expectedBmr)
    }
    
    func testCalculateTdee() {
        var expectedTdee: Float = 0
        var tdee = UserProfileCalculator.calculateTdee(bmr: 1000, activityLevel: "Error")
        XCTAssertEqual(tdee, expectedTdee)
        
        expectedTdee = 1200
        tdee = UserProfileCalculator.calculateTdee(bmr: 1000, activityLevel: ActivityLevel.sedentary.rawValue)
        XCTAssertEqual(tdee, expectedTdee)
        
        expectedTdee = 1375
        tdee = UserProfileCalculator.calculateTdee(bmr: 1000, activityLevel: ActivityLevel.light.rawValue)
        XCTAssertEqual(tdee, expectedTdee)
        
        expectedTdee = 1550
        tdee = UserProfileCalculator.calculateTdee(bmr: 1000, activityLevel: ActivityLevel.moderate.rawValue)
        XCTAssertEqual(tdee, expectedTdee)
        
        expectedTdee = 1725
        tdee = UserProfileCalculator.calculateTdee(bmr: 1000, activityLevel: ActivityLevel.extreme.rawValue)
        XCTAssertEqual(tdee, expectedTdee)
    }
}
