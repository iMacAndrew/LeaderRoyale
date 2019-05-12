//
//  LeaderRoyaleUITests.swift
//  LeaderRoyaleUITests
//
//  Created by Andy Humphries on 5/8/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import XCTest

class LeaderRoyaleUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        // Open leader royale before each test
        app.launch()
    }

    func testOnboardingNext() {
        let nextButton = app.scrollViews.otherElements.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()

        XCTAssertNotNil(app.navigationBars["Clans"].otherElements["Clans"])
    }

    func testOnboardingSwipe() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        let crownElement = scrollViewsQuery.otherElements.containing(.image, identifier:"crown").element
        crownElement.swipeLeft()
        crownElement.swipeLeft()
        crownElement.swipeLeft()
        crownElement.swipeLeft()
        scrollViewsQuery.otherElements.buttons["Next"].tap()

        XCTAssertNotNil(app.navigationBars["Clans"].otherElements["Clans"])
    }

}
