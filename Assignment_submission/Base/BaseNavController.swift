//
//  BaseNavController.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/2/1.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count > 0){
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
}
