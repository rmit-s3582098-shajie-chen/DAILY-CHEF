 //
//  RecipeManager.swift
//  Assignment_1
//
//  Created by SJ cheng on 29/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecipeManager {
    // get the reference to my appdelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // hold a reference to hte managed context
    let managedContext : NSManagedObjectContext 
   
    var recipes = [Recipe]()
    var tmpRecipe = Recipe()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
   func fetchRecipe()
    {
        //ask the recipe class to fetch
        let recipeRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        do {
            //use the managed context to execute the fetch request
            recipes = try managedContext.fetch(recipeRequest)
        } catch  {
            print()
        }
    }
    //save the existing newName of recipe
    func save(newName: String,newPhoto: String, newRecipeDescription: String ) ->Recipe
    {
        //create a managed object entity for the recipe
        let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: managedContext) as! Recipe
        
        //Assign the values from the UI to the entity
        recipe.newName = newName
        recipe.newPhoto = newPhoto
        recipe.newRecipeDescription = newRecipeDescription
        print("inside the save newRecipeDescription ")
//        print(recipe.newRecipeDescription)
        recipes.append(recipe)
        updateDatabase()
        //save to the database
        appDelegate.saveContext()
        return recipe
    }
    //save the existing entity of recipe to the database
    func save(_ recipe: Recipe)
    {
        fetchRecipe()
        recipes.append(recipe)
        updateDatabase()
        appDelegate.saveContext()
    }
    /*
     using the struct to hold the insatance of the model
     */
    fileprivate struct Static
    {
        static var instance: RecipeManager?
    }
    
    class var sharedInstance: RecipeManager
    {
        if !(Static.instance != nil)
        {
            Static.instance  = RecipeManager()
        }
        return Static.instance!
    }
    //get the whole array
    func getRecipeArray() -> [Recipe]  {
       do
       {
        fetchRecipe()
        print("The number of the recipes is ")
        print(recipes.count)
        return recipes
        }
    }
    //get the sindle recipe from the array
    func getSingleRecipe(indexNum : Int ) -> Recipe
    {
        return recipes[indexNum]
    }
    //delete Recipe
    func deleteRecipe(indexNum : Int)
    {
        fetchRecipe()
//        let tmpRecipe = getSingleRecipe(indexNum: indexNum)
//        managedContext.delete(tmpRecipe)
        
        updateDatabase()
    }
    //delete on record
    func deleteRecords(name : String) -> Void { //The function to delete the record
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let result = try? moc.fetch(fetchRequest)
        let resultdata = result as! [Recipe] // result as entity
        for object in resultdata { // Go through the fetched result
            if object.newName == name{ // If there is a match
                moc.delete(object) // delete the object
                break;
            }
        }
        do {
            try moc.save() // Save the delete action
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }

    
    //delete recipe by entity
    func deleteRecipeEntity(needToDelete: Recipe)
    {
        managedContext.delete(needToDelete)
        updateDatabase()
    }
    //create tmp attribute
    func createRecipe(newName: String, newPhoto: String, newRecipeDescription : String)->Recipe
    {
        let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: managedContext) as! Recipe
        //set the attribute of the recipe
        recipe.newName = newName
        recipe.newPhoto = newPhoto
        recipe.newRecipeDescription = newRecipeDescription
        
        return recipe 
    }
    //update value of recipe
    func updateValue(oldRecipe : Recipe, newRecipe: Recipe)
    {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let result = try? moc.fetch(fetchRequest)
        let resultdata = result as! [Recipe] // result as entity
        print(resultdata.count)
        for object in resultdata { // Go through the fetched result
            if object.newName == oldRecipe.newName && object.newPhoto == oldRecipe.newPhoto && object.newRecipeDescription == oldRecipe.newRecipeDescription
            { // If there is a match
                    moc.delete(object)
    //                updateDatabase()
//                    save(newRecipe)
                fetchRecipe()
                recipes.append(newRecipe)
                break;
            }
        }
        do {
            try moc.save() // Save the delete action
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    /*Store the image */
    func saveImage(image: UIImage,recipeName:String) -> String? {
        let fileName = recipeName
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
     func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

        static func createListReicpes(recipeDictionary: [String: AnyObject]) -> [Recipe] {
            // GUARD: Is the "recipes" key in out result?
            guard let recipesArray = recipeDictionary[Base.Food2ForkResponseKeys.Recipes] as? [[String: AnyObject]] else {
                print("Cannot find keys '\(Base.Food2ForkResponseKeys.Recipes)' in \(recipeDictionary).")
                return []
            }
            
            if recipesArray.count == 0 {
                print("No recipes found. ")
                return []
            } else {
                var tempArray = [Recipe]()
                for recipe in recipesArray {
                    // GUARD: Does our image have a key for 'image_url'?
                    guard let imageURLString = recipe[Base.Food2ForkResponseKeys.ImageUrl] as? String else {
                        print("Cannot find key '\(Base.Food2ForkResponseKeys.ImageUrl)'")
                        continue
                    }
                    guard let recipeId = recipe[Base.Food2ForkResponseKeys.RecipeId] as? String else {
                        print("Cannot find key '\(Base.Food2ForkParameterKeys.RecipeId)'")
                        continue
                    }
                    
                    if let recipeTitle = recipe[Base.Food2ForkResponseKeys.Title] as? String, recipeTitle != "" {
                        let tmpRecipe = Recipe()
                        tmpRecipe.name = recipeId
                        tmpRecipe.photo = imageURLString
                        tmpRecipe.recipeDescription = recipeTitle
                        tempArray.append(tmpRecipe)
                    } else {
                        let tmpRecipe = Recipe()
                        tmpRecipe.name = recipeId
                        tmpRecipe.photo = imageURLString
                        tmpRecipe.recipeDescription = "(Untitled)"
                        tempArray.append(tmpRecipe)
                    }
                }
                return tempArray
            }
        }
    
    //delete all of the recipe
    func deleteAllRecipe()
    {
                for Recipe in recipes
                {
                    managedContext.delete(Recipe)
                }
                appDelegate.saveContext()
    }
    /*using the a class variable withou first instantiating the model
     we can use it withou instantiating it directly
    var model = RecipeManager.sharedInstance
     */
    //Save the current state of hte objects in the anaged context in to the database.
    func updateDatabase()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error),\(error.userInfo)")
        }
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    private init()
    {
        managedContext = appDelegate.persistentContainer.viewContext
        fetchRecipe()
        //cleannig the database 
//        for Recipe in recipes
//        {
//            managedContext.delete(Recipe)
//        }
//        appDelegate.saveContext()
    }
}
