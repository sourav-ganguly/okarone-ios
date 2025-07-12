//
//  SearchViewUITests.swift
//  Okarone
//
//  Created by Sourav on 10/6/25.
//

import XCTest

// create a unit test class

class SearchViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }

    func testSearchTextFieldExists() {
        XCTAssertTrue(app.textFields["Search books..."].exists)
    }

    @MainActor
    func testSearchFunctionalityAndClearResults() throws {
        app.activate()
        app.textFields["Search books..."].firstMatch.tap()
        app.typeText("1")

        let book = app.staticTexts["Sample Book 1"]
        XCTAssertTrue(book.waitForExistence(timeout: 2))

        app/*@START_MENU_TOKEN@*/.buttons["xmark.circle.fill"]/*[[".otherElements",".buttons[\"Close\"]",".buttons[\"xmark.circle.fill\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app.textFields["Search books..."].firstMatch.tap()
        app.typeText("2")

        let book2 = app.staticTexts["Sample Book 2"]
        XCTAssertTrue(book2.waitForExistence(timeout: 2))
    }

    func testClearSearchRemovesResults() {
        app.activate()
        app.textFields["Search books..."].firstMatch.tap()
        app.typeText("1")
        let book = app.staticTexts["Sample Book 1"]
        XCTAssertTrue(book.waitForExistence(timeout: 2))

        // Tap the clear button
        app.buttons["xmark.circle.fill"].firstMatch.tap()

        // After clearing, the book result should no longer be visible
        XCTAssertFalse(book.exists)
    }

}
