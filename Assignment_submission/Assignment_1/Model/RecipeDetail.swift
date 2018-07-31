//
//  RecipeDetail.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/2/1.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

struct RecipeDetail {
    let recipeId: String
    let title: String
    let imageUrlString: String
    let sourceUrlString: String
    let food2ForkUrlString: String
    let publisherName: String
    let publisherUrl: String
    let socialRank: Double
    let ingredients: [String]
    
    static func createDetailRecipe(recipeDictionary: [String: AnyObject]) -> RecipeDetail? {
        
        // GUARD: Is the "recipe" key in out result?
        guard let recipe = recipeDictionary[Base.Food2ForkResponseKeys.Recipe] as? [String: AnyObject] else {
            print("Cannot find keys '\(Base.Food2ForkResponseKeys.Recipe)' in \(recipeDictionary).")
            return nil
        }
        guard let imageURLString = recipe[Base.Food2ForkResponseKeys.ImageUrl] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.ImageUrl)'")
            return nil
        }
        guard let recipeId = recipe[Base.Food2ForkResponseKeys.RecipeId] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.RecipeId)'")
            return nil
        }
        guard let sourceUrlString = recipe[Base.Food2ForkResponseKeys.SourceUrl] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.SourceUrl)'")
            return nil
        }
        guard let f2fUrlString = recipe[Base.Food2ForkResponseKeys.F2FUrl] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.F2FUrl)'")
            return nil
        }
        guard let publisherName = recipe[Base.Food2ForkResponseKeys.PublisherName] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.PublisherName)'")
            return nil
        }
        guard let publisherUrl = recipe[Base.Food2ForkResponseKeys.PublisherUrl] as? String else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.PublisherUrl)'")
            return nil
        }
        guard let socialRank = recipe[Base.Food2ForkResponseKeys.SocialRank] as? Double else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.SocialRank)'")
            return nil
        }
        guard let ingredients = recipe[Base.Food2ForkResponseKeys.Ingredients] as? [String] else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.Ingredients)'")
            return nil
        }
        guard let title = recipe[Base.Food2ForkResponseKeys.Title] as? String, title != "" else {
            print("Cannot find key '\(Base.Food2ForkResponseKeys.Ingredients)'")
            return nil
        }
        
        return RecipeDetail(recipeId: recipeId, title: title, imageUrlString: imageURLString, sourceUrlString: sourceUrlString, food2ForkUrlString: f2fUrlString, publisherName: publisherName, publisherUrl: publisherUrl, socialRank: socialRank, ingredients: ingredients)
    }
}

