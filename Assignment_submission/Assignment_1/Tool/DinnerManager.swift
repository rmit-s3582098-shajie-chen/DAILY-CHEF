//
//  DinnerManager.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class DinnerManager: NSObject {
    var allFood:NSMutableArray = NSMutableArray.init()       //the array of all of the food
    var favouriteFood:NSMutableArray = NSMutableArray.init() //favourite food array
    var dailyPlanFood:NSMutableArray = NSMutableArray.init()  //plan food array
    //singleton 
    static let shareSingleManager = DinnerManager()
}
