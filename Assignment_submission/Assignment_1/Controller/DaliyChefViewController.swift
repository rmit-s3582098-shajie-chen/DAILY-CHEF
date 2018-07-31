//
//  DaliyChefViewController.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class DaliyChefViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var recipes = [Recipe]()
    var recipe = Recipe()
    var model = RecipeManager.sharedInstance
    //MARK: the desgin of the daily chef main page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gainRecipesBySearch(searchContent: "")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth = (self.view.frame.width - 40) * 0.5
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth + 30)
        self.collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 0, right: 10)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(DailyChefCollectionViewCell.self, forCellWithReuseIdentifier: "DailyChefCollectionViewCell")
        self.collectionView.alwaysBounceVertical = true
        
        self.searchBar.delegate = self;
        self.searchBar.placeholder = "search"
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        self.gainRecipesBySearch(searchContent: searchBar.text!)
    }
    
    //MARK: the desgin of the collection view and the table view 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyChefCollectionViewCell", for: indexPath) as! DailyChefCollectionViewCell
        //set up cell
        let recipe = self.recipes[indexPath.item]
        cell.icon.sd_setImage(with: URL(string: recipe.photo!), placeholderImage: UIImage(named: ""))
        cell.tip.text = recipe.recipeDescription
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "fixedRecipeDetailViewController") as! fixedRecipeDetailViewController
        let recipe = self.recipes[indexPath.item]
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Network request
    func gainRecipesBySearch(searchContent:String) -> Void {
        recipeWebProvider.sharedProvider.getRecipeFromFood2ForkBySearch(searchContent: searchContent, completionBlock: {
            if recipeWebProvider.sharedProvider.recipes.count == 0 {
                return
            } else {
                self.recipes = recipeWebProvider.sharedProvider.recipes
                self.collectionView?.reloadData()
            }
        })
    }
}
