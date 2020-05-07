//
//  DateFormatterExtensionsTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest


class DateFormatterExtensionsTests: XCTestCase {
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        return df
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCurrentDateString() throws {
        let expectedString = dateFormatter.string(from: Date())
        let currentDateString = dateFormatter.getCurrentDateString()
        
        XCTAssertEqual(expectedString, currentDateString)
    }
    
    func testGetPreviousDateString() throws {
        let expectedString: String = "January 01, 2020"
        let date = dateFormatter.date(from: "January 02, 2020")!
        let dateString = dateFormatter.string(from: date)
        let previousDate = dateFormatter.getPreviousDateString(from: dateString)
        let previousDateString = try XCTUnwrap(previousDate)

        XCTAssertEqual(expectedString, previousDateString)
    }

    func testGetNextDateString() throws {
        let expectedString: String = "January 03, 2020"
        let date = dateFormatter.date(from: "January 02, 2020")!
        let dateString = dateFormatter.string(from: date)
        let nextDate = dateFormatter.getNextDateString(from: dateString)
        let nextDateString = try XCTUnwrap(nextDate)

        XCTAssertEqual(expectedString, nextDateString)
    }
}
