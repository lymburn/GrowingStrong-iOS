//
//  DiaryControllerTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class DiaryControllerTests: XCTestCase {
    
    let controller = DiaryController()
    let mockDateBar = MockDateBar()
    let mockDailyNutritionView = MockDailyNutritionView()
    let mockFoodEntryNetworkHelper = MockFoodEntryNetworkHelperNoError()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller.setupDependencies(dateBar: mockDateBar,
                                     dailyNutritionView: mockDailyNutritionView,
                                     foodEntryNetworkHelper: mockFoodEntryNetworkHelper)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPreviousDatePressed() {
        let expectedDate: String = "December 31, 2019"
        
        controller.previousDatePressed()
        let date = mockDateBar.dateValue
        
        XCTAssertNotNil(date)
        XCTAssertEqual(expectedDate, date)
    }
    
    func testNextDatePressed() {
        let expectedDate: String = "January 02, 2020"
        
        controller.nextDatePressed()
        let date = mockDateBar.dateValue
        
        XCTAssertNotNil(date)
        XCTAssertEqual(expectedDate, date)
    }

}
