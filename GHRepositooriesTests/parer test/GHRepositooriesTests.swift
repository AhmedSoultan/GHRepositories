//
//  GHRepositooriesTests.swift
//  GHRepositooriesTests
//
//  Created by ahmed sultan on 19/09/2021.
//

import XCTest
@testable import GHRepositoories

class GRParserTests: XCTestCase {
    
    var mockGRParser: MockGRParser!

    override func setUpWithError() throws {
        mockGRParser = MockGRParser()
    }
    
    override func tearDownWithError() throws {
        mockGRParser.reset()
    }
    
    func testparseResponse() throws {

        guard let jsonObject = mockGRParser.getJson() else {
            XCTFail()
            fatalError("json cannot be found")
        }
        mockGRParser.shouldReturnError = false

        if let repositeriesResponse = mockGRParser.parseResponse(jsonObject, responseType: RepositoriesResponse.self) {
            XCTAssertNotNil(repositeriesResponse)
        } else {
            XCTFail()
        }
    }
    
    func testParseRepositories() throws {
        guard let jsonObject = mockGRParser.getJson() else {
            XCTFail()
            fatalError("json cannot not found")
        }
        mockGRParser.shouldReturnError = false
        if let repositories = self.mockGRParser.parse(jsonObject, responseType: RepositoriesResponse.self) {
            XCTAssertNotNil(repositories)

        } else {
            XCTFail()
            return
        }
    }
}

