//
//  Quiz_AppUITests.swift
//  Quiz AppUITests
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import XCTest

final class Quiz_AppUITests: XCTestCase {
    func testNavigationToProfileCreation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.cells.children(matching: .other).element.children(matching: .other).element
        
        while !collectionViewsQuery.staticTexts["Criar"].exists {
            collectionViewsQuery.element.swipeLeft()
        }
        
        collectionViewsQuery.staticTexts["Criar"].tap()
        
        XCTAssert(app.staticTexts["Mostre quem você é!"].exists)
    }
}
