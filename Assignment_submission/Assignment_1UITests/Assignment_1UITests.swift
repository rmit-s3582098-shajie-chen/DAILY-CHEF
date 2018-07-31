//
//  Assignment_1UITests.swift
//  Assignment_1UITests
//
//  Created by Shajie Chen on 1/18/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import XCTest

class Assignment_1UITests: XCTestCase {
        
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
    func testScense()
    {
     //test for the four main scense existing or not
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Like"].tap()
        let homeButton = tabBarsQuery.buttons["Home"]
        homeButton.tap()
        tabBarsQuery.buttons["Plan"].tap()
        tabBarsQuery.buttons["Me"].tap()
    }
    func testCreateNewRecipe() {
        let app = XCUIApplication()
        //MARK: Test create new recipe
        XCTAssert(app.tabBars.buttons["Me"].exists)
        app.tabBars.buttons["Me"].tap()
        app.navigationBars["My Recipes"].buttons["Add"].tap()
        //MARK: precondition : Make sure the name label didn't exist
        let recipeNameLabel = app.staticTexts["food"]
        XCTAssert(recipeNameLabel.exists == false)
        //MARK: Action : the user input the data
        let pleaseEnterTheRecipeNameTextField = app.textFields["Please enter the Recipe name "]
//        MARK: the user need to enter the name, and this time the navigation "save" button is blown,
                //only if the user enter the recipe name, the button will be enabled
                XCTAssert(app.navigationBars.buttons["Save"].isEnabled == false)
        pleaseEnterTheRecipeNameTextField.tap()
        pleaseEnterTheRecipeNameTextField.typeText("food")
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        textView.typeText("good food")
        app.navigationBars["food"].buttons["Save"].tap()
//        MARK: PostCondition: the label is existing return ture
                XCTAssert(recipeNameLabel.exists)
        
    }
    
}

//MARK: finding out and delete existing character
extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in "\u{8}" }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
    }
}











