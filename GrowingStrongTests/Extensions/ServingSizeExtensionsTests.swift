//
//  ServingSizeExtensionsTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-05-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
import CoreData
@testable import GrowingStrong

class ServingSizeExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToTextFunction() throws {
        let expectedText = "100.0 g"
        
        let servingSizeEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityNames.servingSize.rawValue,
                                                                                 in: CoreDataManager.shared.context)!
        
        let servingSize = NSManagedObject(entity: servingSizeEntity, insertInto: nil) as! ServingSize
        servingSize.quantity = 100
        servingSize.unit = "g"
        let text = servingSize.toText()
        
        XCTAssertEqual(expectedText, text)
    }

}
