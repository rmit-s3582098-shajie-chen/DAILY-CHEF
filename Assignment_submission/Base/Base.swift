//
//  Base.swift
//  Assignment_1
//
//  Created by SJ cheng on 30/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
import Foundation
class Base
{
    
    // MARK: Food2Fork
    struct Food2Fork {
        static let APIScheme = "https"
        static let APIHost = "food2fork.com"
        static let APIPath = "/api"
        static let APIPathSearch = "/api/search"
        static let APIPathGet = "/api/get"
    }
    
    // MARK: Network Methods
    struct Food2ForkMethods {
        static let Get = "GET"
        static let Search = "SEARCH"
    }
    
    // MARK: Food2Fork Parameter Keys
    struct Food2ForkParameterKeys {
        static let APIKey = "key"
        static let Sort = "sort"            // (optional) How the results should be sorted
        static let Page = "page"            // (optional) Used to get additional results (search only)
        static let SearchQuery = "q"        // (optional) Search Query (Ingredients should be separated by commas). If this is omitted top rated recipes will be returned
        static let RecipeId = "rId"         // Id of desired recipe as returned by Search Query
    }
    
    // MARK: Food2Fork Parameter Values
    struct Food2ForkParameterValues {
        static let APIKey = "b047507faa238b66bebd321538f124ca"
        static let SortByRating = "r"       // Rating based off of social media scores to determine the best recipes
        static let SortByTrending = "t"     // Trend score based on how quickly they are gaining popularity
    }
    
    // MARK: Food2Fork Response Keys
    struct Food2ForkResponseKeys {
        static let Count = "count"                      // Number of recipes in result (Max 30)
        static let Recipes = "recipes"                  // List of Recipe Parameters ->
        static let Recipe = "recipe"
        static let ImageUrl = "image_url"               // URL of the image
        static let SourceUrl = "source_url"             // Original Url of the recipe on the publisher's site
        static let F2FUrl = "f2f_url"                   // Url of the recipe on Food2Fork.com
        static let Title = "title"                      // Title of the recipe
        static let PublisherName = "publisher"          // Name of the Publisher
        static let PublisherUrl = "publisher_url"       // Base url of the publisher
        static let SocialRank = "social_rank"           // The Social Ranking of the Recipe (As determined by our Ranking Algorithm)
        static let Page = "page"                        // The page number that is being returned (To keep track of concurrent requests)
        static let Ingredients = "ingredients"          // The ingredients of this recipe
        static let RecipeId = "recipe_id"               // Id of desired recipe as returned by Search Query
    }
    
    // MARK: String Literals
    struct StringLiterals {
        static let SegueIdentifier = "detailViewSegue"
        static let Ingredients = "Ingredients"
        static let PublisherName = "Name of the Publisher"
        static let PublisherUrl = "Base URL of the publisher"
        static let SocialRank = "Social Ranking"
        static let F2FUrl = "URL of the recipe on Food2Fork.com"
    }
}
