//
//  Someone_s_gramUITests.swift
//  Someone's gramUITests
//
//  Created by Иван Тарасенко on 20.03.2025.
//

import XCTest
import CoreData

final class Someone_s_gramUITests: XCTestCase {
    
    let accessibility = AccessibilityIdentifier()

    var app: XCUIApplication!
    
    // DetailCV
    var fullImage: XCUIElement!
    var shareButton: XCUIElement!
    var saveButton: XCUIElement!
    
    // TableView
    var tableView: XCUIElement!
    
    // TableViewCell
    var avatarImageView: XCUIElement!
    var nameLabel: XCUIElement!
    var mainImageView: XCUIElement!
    var descriptionLabel: XCUIElement!
    var likeButton: XCUIElement!
    var numberOfLikesLabel: XCUIElement!
    var createdAtLabel: XCUIElement!
    var skeletonView: XCUIElement!
    
    

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // Включаем использование моков
        app.launchArguments.append("--use-mock-data")
        app.launch()
    
        fullImage = app.images[accessibility.fullImage]
        shareButton = app.buttons[accessibility.shareButton]
        saveButton = app.buttons[accessibility.saveButton]
        
        tableView = app.tables[accessibility.tableView]
        
        avatarImageView = app.images[accessibility.avatarImageView]
        nameLabel = app.staticTexts[accessibility.nameLabel]
        mainImageView = app.images[accessibility.mainImageView]
        descriptionLabel = app.staticTexts[accessibility.descriptionLabel]
        likeButton = app.buttons[accessibility.likeButton]
        numberOfLikesLabel = app.staticTexts[accessibility.numberOfLikesLabel]
        createdAtLabel = app.staticTexts[accessibility.createdAtLabel]
        skeletonView = app.otherElements[accessibility.skeletonView]
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testPresenceOfUIElements() {
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(avatarImageView.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(mainImageView.exists)
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(likeButton.exists)
        XCTAssertTrue(numberOfLikesLabel.exists)
        XCTAssertTrue(createdAtLabel.exists)
    }
    
    func testTapOnPostOpensDetailScreen() {
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        
        firstCell.tap()
        
        XCTAssertTrue(fullImage.exists)
        XCTAssertTrue(shareButton.exists)
        XCTAssertTrue(saveButton.exists)
    }
    
    func testLikeButtonIncrementsLikes() {
           let cell = tableView.cells.element(boundBy: 0)
           
           let initialLikes = cell.staticTexts[accessibility.numberOfLikesLabel].label
           
           cell.buttons[accessibility.likeButton].tap()
           
           let updatedLikes = cell.staticTexts[accessibility.numberOfLikesLabel].label
           XCTAssertNotEqual(initialLikes, updatedLikes, "Количество лайков не изменилось после нажатия")
    }
    
    func testInfiniteScrollingLoadsMoreData() {
        let initialCellsCount = tableView.cells.count
        for _ in 0...10 {
            tableView.swipeUp()
        }
        let newCellsCount = tableView.cells.count
        XCTAssertGreaterThan(newCellsCount, initialCellsCount, "Новые данные не подгрузились")
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}
