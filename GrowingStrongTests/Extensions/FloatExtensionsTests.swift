//
//  FloatExtensionsTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-08-31.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class FloatExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClean() {
        var float: Float = 2.12
        var cleanedFloat = float.clean
        var expectedFloat = "2.12"
        XCTAssertEqual(expectedFloat, cleanedFloat)

        
        float = 2.0
        cleanedFloat = float.clean
        expectedFloat = "2"
        XCTAssertEqual(expectedFloat, cleanedFloat)
    }

    func testToOneDecimalString() {
        let float: Float = 2.123
        let expectedFloat = "2.1"
        
        XCTAssertEqual(float.toOneDecimalString, expectedFloat)
    }
}
