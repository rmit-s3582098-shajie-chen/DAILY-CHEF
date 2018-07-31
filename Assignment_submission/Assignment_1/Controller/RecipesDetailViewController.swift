//
//  RecipesDetailViewController.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/19/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
import os.log

class RecipesDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CameraViewControllerDelegate {

     
    @IBOutlet weak var recipePhotoView: UIImageView!
    @IBOutlet weak var RecipeNameTextfield: UITextField!
    @IBOutlet weak var DescriptionTextfield: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var model = RecipeManager.sharedInstance
    var recipe : Recipe?
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    //MARK: Navigation
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
//
        let newName = RecipeNameTextfield.text
        let newPhoto = recipePhotoView.image
        let newRecipeDescription = DescriptionTextfield.text
        var fileName:String
        fileName = model.saveImage(image: newPhoto!,recipeName: newName!)!
        
        // Set the recipe to be passed to RecipesDetailViewController after the unwind segue.
        recipe = model.createRecipe(newName: newName!, newPhoto: fileName ,newRecipeDescription: newRecipeDescription!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        RecipeNameTextfield.delegate = self
      
        // Set up views if editing an existing Recipe.
        if let recipe = recipe {
            navigationItem.title = recipe.newName
            RecipeNameTextfield.text   = recipe.newName
            if(recipe.newPhoto != nil){
                recipePhotoView.image =  model.load(fileName: recipe.newPhoto!)
            }
            if recipe.newRecipeDescription != nil
            {
            DescriptionTextfield.text = recipe.newRecipeDescription
            }else
            {
                DescriptionTextfield.text = "Some problem apear here, please enter your description"
            }
            
        }
        
         // Enable the Save button only if the text field has a valid Recipe newName.
        updateSaveButtonState()
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageClick))
        self.recipePhotoView.addGestureRecognizer(tap)
    }
    @objc func imageClick() -> Void {
        print("imageClick")
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func cameraViewConformClick(image: UIImage?) {
        self.recipePhotoView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController

        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The RecipeViewController is not inside a navigation controller.")
        }
           dismiss(animated: true, completion: nil)
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = RecipeNameTextfield.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
