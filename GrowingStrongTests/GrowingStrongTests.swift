//
//  GrowingStrongTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-04-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class MeasurementUnitHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCentimetersToFeetInches() throws {
        var metricLength: Double = 181.0
        var expectedFeetInchesString: String = "5 ft 11 in"
        var feetInchesString: String = MeasurementUnitHelper.centimetersToFeetInches(metricLength)
        
        XCTAssertEqual(feetInchesString, expectedFeetInchesString)
        
        metricLength = 183.0
        expectedFeetInchesString = "6 ft 0 in"
        feetInchesString = MeasurementUnitHelper.centimetersToFeetInches(metricLength)
        
        XCTAssertEqual(feetInchesString, expectedFeetInchesString)
    }
    
    func testKilogramsToPounds() throws {
        let kilogram: Double = 50.0
        let expectedPounds: Double = Measurement(value: 50.0, unit: UnitMass.kilograms).converted(to: .pounds).value
        let pounds: Double = MeasurementUnitHelper.kilogramsToPounds(kilogram)
        
        XCTAssertEqual(expectedPounds, pounds)
    }
}
