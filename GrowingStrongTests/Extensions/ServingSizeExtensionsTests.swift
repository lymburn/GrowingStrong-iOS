//
//  ServingExtensionsTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
import CoreData
@testable import GrowingStrong

class ServingExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetServingSizeTextFunction() throws {
        let expectedText = "100.0 g"
        
        let servingEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityNames.serving.rawValue, in: CoreDataManager.shared.mainContext)!
        
        let serving = NSManagedObject(entity: servingEntity, insertInto: nil) as! Serving
        serving.quantity = 100
        serving.unit = "g"
        let text = serving.getServingSizeText()
        
        XCTAssertEqual(expectedText, text)
    }

}
