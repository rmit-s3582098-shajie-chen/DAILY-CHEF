//
//  FavouriteListTableViewController.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/20/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit

class FavouriteListTableViewController: UITableViewController {
    var recipes = [Recipe]()
    var model = RecipeManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = DinnerManager.shareSingleManager.favouriteFood as! [Recipe]
        self.tableView.reloadData()
        print(recipes)
    }

    // MARK: - Table view data source , and all of the table layout s
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FavouriteListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavouriteListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of .")
        }
        let recipe = recipes[indexPath.row]
        cell.photoImageView.sd_setImage(with: URL(string: recipe.photo!), placeholderImage: UIImage(named: ""))
        cell.descriptionText.text = recipe.title
        return cell
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "fixedRecipeDetailViewController") as! fixedRecipeDetailViewController
        let recipe = self.recipes[indexPath.item]
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
