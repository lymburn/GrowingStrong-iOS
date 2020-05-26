//
//  DiaryControllerTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest

class DiaryControllerTests: XCTestCase {
    
    let controller = DiaryController()
    let mockDateBar = MockDateBar()
    let mockDailyNutritionView = MockDailyNutritionView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller.setupDateBar(mockDateBar)
        controller.setupDailyNutritionView(mockDailyNutritionView)
        controller.setupFoodEntryViewModels(testFoodEntries.map({return FoodEntryViewModel.init(foodEntry: $0)}))
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

class MockDateBar: DateBarType {
    var dateValue: String?
    
    func getDateValue() -> String {
        return "January 01, 2020"
    }
    
    func setDateValue(text: String?) {
        dateValue = text
    }
}

class MockDailyNutritionView: DailyNutritionViewType {
    func getCaloriesValueLabel() -> String {
        return ""
    }
    
    func getCarbsValueLabel() -> String {
        return ""
    }
    
    func getFatValueLabel() -> String {
        return ""
    }
    
    func getProteinValueLabel() -> String {
        return ""
    }
}
