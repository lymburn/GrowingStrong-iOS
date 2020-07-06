//
//  DateExtensionsTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-26.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class DateExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsEqualTo() throws {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 5
        dateComponents.day = 26
        dateComponents.timeZone = TimeZone.current
        let date1 = calendar.date(from: dateComponents)!
        var date2 = calendar.date(from: dateComponents)!
        
        XCTAssertTrue(date1.isEqualTo(date: date2, by: .day))
        XCTAssertTrue(date1.isEqualTo(date: date2, by: .month))
        XCTAssertTrue(date1.isEqualTo(date: date2, by: .year))
        
        dateComponents.day = 27
        date2 = calendar.date(from: dateComponents)!
        XCTAssertFalse(date1.isEqualTo(date: date2, by: .day))
    }

}
