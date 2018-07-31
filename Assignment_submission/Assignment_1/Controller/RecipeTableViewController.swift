//
//  RecipeTableViewController.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/18/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
import os.log

class RecipeTableViewController: UITableViewController {

    //Make: Properties
    
    //create the model as RecipeManager sharedInstance
    var model = RecipeManager.sharedInstance
    var Recipes = [Recipe]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = nil
        // load from the database
        Recipes = model.getRecipeArray() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Recipes.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of .")
        }
        // Configure the cell...
        // Fetches the appropriate recipe for the data source layout.
        let recipe = Recipes[indexPath.row]
        cell.RecipesNameLabel.text = recipe.newName
        if((recipe.newPhoto) != nil){
            cell.photoImageView.image = model.load(fileName: recipe.newPhoto!)
        }
        cell.RecipesDescription.text = recipe.newRecipeDescription
        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Recipes.remove(at: indexPath.row) 
            let tmprecipe = model.getSingleRecipe(indexNum: indexPath.row)
            model.deleteRecords(name: tmprecipe.newName!)
            Recipes = model.getRecipeArray()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            switch(segue.identifier ?? "") {
                case "AddItem":
                    os_log("Adding a new Recipe.", log: OSLog.default, type: .debug)
                case "ShowDetail":
                    guard let recipesDetailViewController = segue.destination as? RecipesDetailViewController else {
                        fatalError("Unexpected destination: \(segue.destination)")
                    }
                    
                    guard let selectedRecipesCell = sender as? RecipesTableViewCell else {
                        fatalError("Unexpected sender: \(String(describing: sender))")
                    }
                    
                    guard let indexPath = tableView.indexPath(for: selectedRecipesCell) else {
                        fatalError("The selected cell is not being displayed by the table")
                    }
                  
                    let selectedRecipe = model.getSingleRecipe(indexNum: indexPath.row)
                    recipesDetailViewController.recipe = selectedRecipe
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
      
        if let sourceViewController = sender.source as? RecipesDetailViewController, let recipe = sourceViewController.recipe {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Recipe.
                model.updateValue(oldRecipe: Recipes[selectedIndexPath.row], newRecipe: recipe)
                Recipes = model.getRecipeArray()
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
            // Add a new meal.
                model.save(recipe)
                Recipes = model.getRecipeArray()
                print("after call the save function ")
                self.tableView.reloadData() 
            }
        }
    }
    

}
