//
//  Recipe+CoreDataClass.swift
//  Assignment_1
//
//  Created by SJ cheng on 29/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {
  var name: String?
  var recipeDescription: String?
  var photo: String?
    
  var type: Int?    //
  var title:String? //title
}
