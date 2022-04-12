//
//  StatViewTest.swift
//  RestTimeUITests
//
//  Created by Joey Green on 2022/4/11.
//

import XCTest

class StatViewTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    /// FIXME
    func testExample() throws {
        app.buttons["StatisticsTab"].tap()
    }

}
