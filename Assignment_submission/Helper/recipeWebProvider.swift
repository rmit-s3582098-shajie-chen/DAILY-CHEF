//
//  DataRequest.swift
//  Assignment_1
//
//  Created by SJ cheng on 30/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
import Alamofire
protocol Update{
    func update(response: String)
}

class recipeWebProvider{
    static let sharedProvider = recipeWebProvider()
    var recipes = [Recipe]()

    //Request for Network
    func getRecipeFromFood2ForkBySearch(searchContent: String, completionBlock: @escaping (() -> ())){
        let parameters = [Base.Food2ForkParameterKeys.SearchQuery: searchContent as AnyObject]
        let method = Base.Food2ForkMethods.Search
        let NetworkClient = networkClient()
        NetworkClient.taskForSEARCHMethod(method: method, parameters: parameters) { (result, error) in
            guard let result = result else {
                print("\(String(describing: error))")
                completionBlock()
                return
            }
            self.recipes = RecipeManager.createListReicpes(recipeDictionary: result)
            performUIUpdatesOnMain {
                completionBlock()
            }
        }
    }
}
