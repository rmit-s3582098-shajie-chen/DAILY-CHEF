//
//  DailyPlanViewController.swift
//  Assignment_1
//
//  Created by shaji chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit
//following of code uses the delegation desgin pattern 
class DailyPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DailyPlanViewTableViewCellDelete {
    @IBOutlet weak var listView: UITableView!
    //create the list to store the recipe from the plan list
    var recipes = [Recipe]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.separatorStyle = .none
        self.listView.showsVerticalScrollIndicator = false
        self.listView.rowHeight = 100;
        self.listView.estimatedSectionFooterHeight = 0
        self.listView.estimatedSectionHeaderHeight = 0
        self.listView.delegate = self
        self.listView.dataSource = self
        self.listView.register(DailyPlanViewTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: "DailyPlanViewTableViewSectionHeader")
        self.listView.register(DailyPlanViewTableViewCell.self, forCellReuseIdentifier: "DailyPlanViewTableViewCell")
        self.view.addSubview(self.listView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = DinnerManager.shareSingleManager.dailyPlanFood as! [Recipe]
        self.listView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //MARK: desgin the table view 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyPlanViewTableViewCell", for: indexPath) as! DailyPlanViewTableViewCell
        cell.delegate = self    //setting delegation
        print(self.recipes.count)
        if(indexPath.section == 0){
            cell.recipes = self.getLunchType(type: 0)
        }else if(indexPath.section == 1){
            cell.recipes = self.getLunchType(type: 1)
        }else if(indexPath.section == 2){
            cell.recipes = self.getLunchType(type: 2)
        }else if(indexPath.section == 3){
            cell.recipes = self.getLunchType(type: 3)
        }
        return cell
    }
    
    func getLunchType(type:Int) -> [Recipe] {
        let tmpArr = NSMutableArray.init();
        for recipe in self.recipes {
            if(recipe.type == type){
                tmpArr.add(recipe)
            }
        }
        return tmpArr as! [Recipe]
    }
    
    //delete implement the delegation 
    func dailyPlanCellClick(recipe: Recipe) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "fixedRecipeDetailViewController") as! fixedRecipeDetailViewController
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DailyPlanViewTableViewSectionHeader") as! DailyPlanViewTableViewSectionHeader
        let type:[String] = ["Breakfast/Bruch","lunch","Dinner","Dessert"]
        header.dinnerType.text = type[section]
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
