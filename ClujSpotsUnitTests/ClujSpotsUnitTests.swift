//
//  ClujSpotsUnitTests.swift
//  ClujSpotsUnitTests
//
//  Created by Birladeanu, Alexandru on 26.03.2024.
//

import XCTest
@testable import ClujSpots

final class ClujSpotsUnitTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {}
    
    func testNetworkCall() throws {
        let timeout: TimeInterval = 10
        let networkService = NetworkService()
        let objectToTest = MapViewModel(networkServiceProtocol: networkService)
        let expectation = XCTestExpectation()
        
        objectToTest.getRemoteData { result in
            XCTAssertNotEqual(result.isEmpty, true)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeout)
    }
}
