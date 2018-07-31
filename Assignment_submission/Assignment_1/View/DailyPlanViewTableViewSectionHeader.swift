//
//  DailyPlanViewTableViewSectionHeader.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class DailyPlanViewTableViewSectionHeader: UITableViewHeaderFooterView {
    //MARK: the variable of the cell
    var icon:UIImageView!
    var dinnerType:UILabel!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.icon = UIImageView.init()
        self.icon.image = UIImage.init(named: "icons8-food-filled-26")
        self.addSubview(self.icon)
        
        self.dinnerType = UILabel.init()
        self.dinnerType.text = "lunch"
        self.dinnerType.font = UIFont.systemFont(ofSize: 13)
        self.dinnerType.textColor = UIColor.lightGray
        self.addSubview(self.dinnerType)
    }
    //MARK: the initilization of the cell
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: the desgin of the view 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.icon.frame = CGRect.init(x: 10, y: (self.height - 13) * 0.5, width: 13, height: 13)
        self.dinnerType.sizeToFit()
        self.dinnerType.frame = CGRect.init(x: self.icon.right + 5, y: (self.height - self.dinnerType.height) * 0.5, width: self.dinnerType.width, height: self.dinnerType.height)
    }
}
