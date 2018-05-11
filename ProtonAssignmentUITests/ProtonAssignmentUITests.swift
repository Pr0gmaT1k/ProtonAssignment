//
//  ProtonAssignmentUITests.swift
//  ProtonAssignmentUITests
//
//  Created by azerty on 07/05/2018.
//  Copyright © 2018 proton. All rights reserved.
//

import XCTest

class ProtonAssignmentUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOpenCloseAddTask() {
        let app = XCUIApplication()
        app.navigationBars["HOMEWORK"].buttons["Add"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element(boundBy: 1).tap()
    }
    
    /** Scroll over all screen in page menu */
    func testNavigate() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        let emptyElement = scrollViewsQuery.otherElements.containing(.image, identifier:"empty").element
        emptyElement.swipeLeft()
        
        let thereIsNoTaskInProgressElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"There is no task in progress").element
        thereIsNoTaskInProgressElement.swipeLeft()
        emptyElement.swipeRight()
        thereIsNoTaskInProgressElement.swipeRight()
    }
}
