//
//  DailyChefCollectionViewCell.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class DailyChefCollectionViewCell: UICollectionViewCell {
    //Mark: the variable of the cell
    var icon:UIImageView!
    var tip:UILabel!
    //MARK: the initilizaiton of the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.icon = UIImageView.init()
        self.icon.image = UIImage.init(named: "breakfast")
        self.icon.contentMode = .scaleAspectFill
        self.icon.clipsToBounds = true
        self.icon.layer.cornerRadius = 8
        self.icon.clipsToBounds = true
        self.tip = UILabel.init()
        self.tip.text = "garlic Beef"
        self.tip.textAlignment = .center
        self.contentView.addSubview(self.icon)
        self.contentView.addSubview(self.tip)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: the desgin of the cell 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.icon.frame = CGRect.init(x: 0, y: 0, width: self.contentView.width, height: self.contentView.height - 30)
        self.tip.sizeToFit()
        self.tip.frame = CGRect.init(x: 0, y: self.icon.bottom , width: self.contentView.width, height: 30)
    }
}
