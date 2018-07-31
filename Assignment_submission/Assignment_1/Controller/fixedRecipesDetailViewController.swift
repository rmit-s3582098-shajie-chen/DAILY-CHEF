//
//  fixedRecipesDetailViewController.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/23/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit

class fixedRecipesDetailViewController: UIViewController {

    @IBOutlet weak var fixedImageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addToPlan(_ sender: Any) {
    }
    @IBAction func love(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
}
