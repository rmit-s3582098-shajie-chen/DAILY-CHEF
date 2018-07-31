//
//  fixedRecipeDetailViewController.swift
//  Assignment_1
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class fixedRecipeDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var listView: UITableView!
    var recipe:Recipe?
    var detailRecipe: RecipeDetail?

    //MARK: show the detial when the page load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: 200))
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.sd_setImage(with: URL(string: (self.recipe?.photo)!), placeholderImage: UIImage(named: ""))
        self.listView.tableHeaderView = headerImageView
        
        self.listView.dataSource = self
        self.listView.delegate = self
        self.listView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.getRecipeFromFood2Fork()
    }
    
    //MARK: action, when the user click on the
    //MARK: the page from the recipe detial, when the user click on the "add", it will add it to the daily plan array
    @IBAction func addToPlan(_ sender: Any) {
        let alertController = UIAlertController(title: "Would you want to add it to Daily Plan ?",
                                                message: "If you click yes, the recipe will be classified added to your daily plan automatically", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "YES", style: .default, handler: {
            action in
            
            let recipes = DinnerManager.shareSingleManager.dailyPlanFood as! [Recipe]
            
            for tmpRecipe:Recipe in recipes{
                if(self.recipe?.name == tmpRecipe.name){
                    let alert = UIAlertController.init(title: "Add", message: "repetition add", preferredStyle: .alert)
                    let cancelAction = UIAlertAction.init(title: "Cancle", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            self.recipe?.type = Int(arc4random() % 4)
            DinnerManager.shareSingleManager.dailyPlanFood.add(self.recipe as Any)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func love(_ sender: Any) {
        //MARK: check the recipes whether it have redundant.
        let recipes = DinnerManager.shareSingleManager.favouriteFood as! [Recipe]
        for tmpRecipe:Recipe in recipes{
            if(self.recipe?.name == tmpRecipe.name){
                let alert = UIAlertController.init(title: "Like", message: "repetition add", preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "Cancle", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        DinnerManager.shareSingleManager.favouriteFood.add(recipe!)
    }
    
    // MARK: Network request
    func getRecipeFromFood2Fork() {
        let parameters = [Base.Food2ForkParameterKeys.RecipeId: recipe?.name as AnyObject]
        let method = Base.Food2ForkMethods.Get
        
        let netwotkClient = networkClient()
        
        netwotkClient.taskForGETMethod(method: method, parameters: parameters) { (result, error) in
            guard let result = result else {
                print("\(String(describing: error))")
                return
            }
            let detailRecipe = RecipeDetail.createDetailRecipe(recipeDictionary: result)
            performUIUpdatesOnMain {
                self.detailRecipe = detailRecipe
                self.recipe?.title = self.detailRecipe?.title
                self.listView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return detailRecipe?.ingredients.count ?? 0
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = detailRecipe?.ingredients[indexPath.row]
        case 1:
            cell.textLabel?.text = detailRecipe?.publisherName
        case 2:
            cell.textLabel?.text = detailRecipe?.publisherUrl
        default:
            cell.textLabel?.text = detailRecipe?.food2ForkUrlString
        }
        
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Base.StringLiterals.Ingredients
        case 1:
            return Base.StringLiterals.PublisherName
        case 2:
            return Base.StringLiterals.PublisherUrl
        default:
            return Base.StringLiterals.F2FUrl
        }
    }
}
