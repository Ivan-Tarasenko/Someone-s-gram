//
//  NetworkServiceUnitTests.swift
//  Someone's gramTests
//
//  Created by Иван Тарасенко on 21.03.2025.
//

import XCTest
@testable import Someone_s_gram

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        networkService.useMockData = true // Принудительно включаем моковые данные
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testFetchPost_usesMockData() {
        let expectation = self.expectation(description: "Используем моковые данные")
        
        networkService.fetchPost(page: 1) {
            XCTAssertTrue(CoreDataService.shared.isSavedContext(), "Моковые данные не сохранились")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
