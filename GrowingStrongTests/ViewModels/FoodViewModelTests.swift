//
//  FoodViewModelTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest

class FoodViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFoodViewModel() throws {
        let expectedTotalCalories = 1000
        let expectedTotalCaloriesText = "1000 kcal"
        let expectedTotalQuantity = 3
        let expectedTotalQuantityText = "3 lb"
        
        let food = Food(id: 0, name: "Chicken", servingSizeQuantity: 1.5, servingSizeUnit: ServingSizeUnit.pound, servingAmount: 2, caloriesPerServing: 500)
        let foodViewModel = FoodViewModel(food: food)
        
        XCTAssertEqual(foodViewModel.totalCalories, expectedTotalCalories)
        XCTAssertEqual(foodViewModel.totalCaloriesText, expectedTotalCaloriesText)
        XCTAssertEqual(foodViewModel.totalQuantity, expectedTotalQuantity)
        XCTAssertEqual(foodViewModel.totalQuantityText, expectedTotalQuantityText)
    }

}
