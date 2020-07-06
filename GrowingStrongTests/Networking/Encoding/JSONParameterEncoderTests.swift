//
//  JSONParameterEncoderTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class JSONParameterEncoderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncodingWithoutError() throws {
        let url = URL(string: "localhost:5000/api/user")!
        var request = URLRequest(url: url)
        let jsonParameters = ["testKey": "testValue"]
        
        XCTAssertNil(request.httpBody)
        XCTAssertNoThrow(try JSONParameterEncoder.encode(urlRequest: &request, with: jsonParameters))
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertNotNil(request.httpBody)
    }
}
