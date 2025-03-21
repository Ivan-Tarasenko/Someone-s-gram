//
//  CoreDataServiceTests.swift
//  Someone's gramTests
//
//  Created by Иван Тарасенко on 21.03.2025.
//

import XCTest
@testable import Someone_s_gram

class CoreDataServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        CoreDataService.shared.clearDatabase()
    }
    
    override func tearDown() {
        CoreDataService.shared.clearDatabase()
        super.tearDown()
    }
    
    func testClearDatabase() {
        let posts = CoreDataService.shared.fetchSavedContext()
        XCTAssertEqual(posts.count, 0, "База данных не очистилась")
    }
}

