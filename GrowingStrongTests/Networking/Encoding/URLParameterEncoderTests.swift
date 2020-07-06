//
//  URLParameterEncoderTests.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import XCTest
@testable import GrowingStrong

class URLParameterEncoderTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEncodeWithoutError() throws {
        let url = URL(string: "localhost:5000/api/user")!
        let expectedUrl = URL(string: "localhost:5000/api/user?testKey=testValue")!
        var request = URLRequest(url: url)
        let urlParameters = ["testKey": "testValue"]
        
        XCTAssertNoThrow(try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters))
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Content-Type"))
        XCTAssertEqual(request.url, expectedUrl)
    }

    func testEncodeWithError() throws {
        let url = URL(string: "localhost:5000/api/user")!
        var request = URLRequest(url: url)
        request.url = nil
        let urlParameters = ["testKey": "testValue"]
        
        XCTAssertThrowsError(try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters))
    }
}
