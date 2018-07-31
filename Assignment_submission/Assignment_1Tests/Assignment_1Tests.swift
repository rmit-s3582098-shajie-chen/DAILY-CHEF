//
//  Assignment_1Tests.swift
//  Assignment_1Tests
//
//  Created by Shajie Chen on 1/18/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import XCTest
//@testable import Assignment_1
@testable import Assignment_1
class Assignment_1Tests: XCTestCase {
    var recipe : Recipe = Recipe()
    var detailRecipe : DetailRecipe = DetailRecipe()
    //Mark :Recipe class test
    override func setUp() {
        super.setUp()
        //put setup code here, this methohd is called before the invocation of each test method in the class
        
    }
    override func tearDown() {
         super.tearDown()
        //put teardown code here. this method is called after the invocation of each test methid in the class
    }
    
    /* Four seperate Unit test
     *
     * 1. test API request not be nil
     * 2. test database connection.
     * 3. test save recipe (add it to the My recipe list)
     * 4. test delete all of my recipe
     *
     */
    
     func testAPIRequestNotNull(){
       //test the web connection
        var recipes = [Recipe]()
        let searchContent = "Chicken"
        recipeWebProvider.sharedProvider.getRecipeFromFood2ForkBySearch(searchContent: searchContent, completionBlock: {
                if recipeWebProvider.sharedProvider.recipes.count == 0 {
                    return
                } else {
                     recipes = recipeWebProvider.sharedProvider.recipes
                }
            })
        XCTAssertNotNil(recipes,"Request result is null")
    }
    
    func testDatabaseConnection(){
        //to test the database connection
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //POSTcondition: the managedContext not be nil, it must be connected
        XCTAssertNotNil(managedContext,"Connection failed")
    }
    
    
    func testSaveMyRecipe(){
        //to test the save recipe
        let model = RecipeManager.sharedInstance
        let numberBeforeInsert = model.getRecipeArray().count
        model.save(newName: "Hello", newPhoto: "defaultPhoto", newRecipeDescription: "None")
        let numberAfterInsert = model.getRecipeArray().count
        
        let substract = numberAfterInsert - numberBeforeInsert
        XCTAssertEqual(substract, 1)
    }
    
     func testDeleteAllMyRecipe(){
        //to test delete all the recipe
        //all of the my recipe are located in the database
        let model = RecipeManager.sharedInstance
        //action : delete all of the recipe
        model.deleteAllRecipe()
        
        //postcondition : the array of the recipe should be zero
        var recipes = [Recipe]()
        recipes = model.getRecipeArray()
        
        XCTAssertEqual(recipes.count, 0)
    }
}
