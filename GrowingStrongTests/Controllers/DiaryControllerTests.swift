//
//  DiaryControllerTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
import CoreData

@testable import GrowingStrong

class DiaryControllerTests: XCTestCase {
    
    let controller = DiaryController()
    let mockDateBar = MockDateBar()
    let mockDailyNutritionView = MockDailyNutritionView()
    let mockFoodEntryNetworkHelper = MockFoodEntryNetworkHelperNoError()
    let currentUser = createMockCurrentUser()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller.setupDependencies(dateBar: mockDateBar,
                                     dailyNutritionView: mockDailyNutritionView,
                                     foodEntryNetworkHelper: mockFoodEntryNetworkHelper)
        
        controller.foodEntryViewModels = []
        controller.currentUser = currentUser
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

fileprivate func createMockCurrentUser() -> User {
    let userEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityNames.user.rawValue, in: CoreDataManager.shared.mainContext)!
    
    let user = NSManagedObject(entity: userEntity, insertInto: nil) as! User
    user.emailAddress = "test123@gmail.com"
    user.profile.activityLevel = ActivityLevel.moderate.rawValue
    user.profile.height = 180
    user.profile.weight = 80
    user.profile.birthDate = Date()
    user.profile.sex = "Male"
    user.profile.tdee = 2000
    user.profile.bmr = 1500
    user.targets.goalWeight = 70
    user.targets.weightGoalTimeline = WeightGoalTimeline.maintainWeight.rawValue
    
    return user
}
