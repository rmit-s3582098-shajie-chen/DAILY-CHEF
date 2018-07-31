//
//  Recipe+CoreDataProperties.swift
//  Assignment_1
//
//  Created by SJ cheng on 29/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged var newName: String?
    @NSManaged var newRecipeDescription: String?
    @NSManaged var newPhoto: String?
}
