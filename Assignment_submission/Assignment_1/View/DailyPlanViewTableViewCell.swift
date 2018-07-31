//
//  DailyPlanViewTableViewCell.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

//delegate

@objc protocol DailyPlanViewTableViewCellDelete:NSObjectProtocol {
    @objc optional func dailyPlanCellClick(recipe:Recipe)
}

class DailyPlanViewTableViewCell: UITableViewCell {
    //MARK: define the basic variable of the cell
    var foodOneIcon: UIButton!
    var foodTwoIcon: UIButton!
    var foodThreeIcon: UIButton!
    weak var delegate:DailyPlanViewTableViewCellDelete?
    
    var recipes:[Recipe]?{
        didSet{
            if(recipes?.count == 1){
                let recipe = recipes?.first
                self.foodOneIcon.sd_setImage(with: URL(string: (recipe?.photo)!), for: .normal, completed: nil)
                self.foodOneIcon.isHidden = false
                self.foodTwoIcon.isHidden = true
                self.foodThreeIcon.isHidden = true
            }
            else if(recipes?.count == 2){
                let recipe = recipes?.first
                self.foodOneIcon.sd_setImage(with: URL(string: (recipe?.photo)!), for: .normal, completed: nil)
                
                let recipe2 = recipes?.last
                self.foodTwoIcon.sd_setImage(with: URL(string: (recipe2?.photo)!), for: .normal, completed: nil)
                self.foodOneIcon.isHidden = false
                self.foodTwoIcon.isHidden = false
                self.foodThreeIcon.isHidden = true
            }
            else if(recipes?.count == 3){
                let recipe = recipes?.first
                self.foodOneIcon.sd_setImage(with: URL(string: (recipe?.photo)!), for: .normal, completed: nil)
                
                let recipe2 = recipes?[1]
                self.foodTwoIcon.sd_setImage(with: URL(string: (recipe2?.photo)!), for: .normal, completed: nil)
                
                let recipe3 = recipes?.last
                self.foodThreeIcon.sd_setImage(with: URL(string: (recipe3?.photo)!), for: .normal, completed: nil)
                self.foodOneIcon.isHidden = false
                self.foodTwoIcon.isHidden = false
                self.foodThreeIcon.isHidden = false
            }
            self.setNeedsLayout()
        }
    }

    //MARK: initilation the cell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.foodOneIcon = UIButton.init()
        self.foodOneIcon.imageView?.contentMode = .scaleAspectFill

        self.foodOneIcon.tag = 1
        self.foodOneIcon.addTarget(self, action: #selector(foodClick(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.foodOneIcon)
        
        self.foodTwoIcon = UIButton.init()
        self.foodTwoIcon.imageView?.contentMode = .scaleAspectFill

        self.foodTwoIcon.tag = 2
        self.foodTwoIcon.addTarget(self, action: #selector(foodClick(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.foodTwoIcon)
        
        self.foodThreeIcon = UIButton.init()
        self.foodThreeIcon.imageView?.contentMode = .scaleAspectFill

        self.foodThreeIcon.tag = 3
        self.foodThreeIcon.addTarget(self, action: #selector(foodClick(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.foodThreeIcon)
        
        self.foodOneIcon.isHidden = true
        self.foodTwoIcon.isHidden = true
        self.foodThreeIcon.isHidden = true
    }
    @objc func foodClick(_ button:UIButton){
        print("button.tag === \(button.tag)")
        if((self.delegate) != nil){
            let recipe = self.recipes![button.tag - 1]
            self.delegate?.dailyPlanCellClick!(recipe: recipe)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: desgin of the cell showing
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconWidth = (self.contentView.width - 20) / 3
        if(self.recipes?.count == 1){
            self.foodOneIcon.frame = CGRect.init(x: 10, y: 0, width: iconWidth, height: self.contentView.height)
        }else if(self.recipes?.count == 2){
            self.foodOneIcon.frame = CGRect.init(x: 10, y: 0, width: iconWidth, height: self.contentView.height)
            self.foodTwoIcon.frame = CGRect.init(x: iconWidth, y: 0, width: iconWidth, height: self.contentView.height)
        }else{
            self.foodOneIcon.frame = CGRect.init(x: 10, y: 0, width: iconWidth, height: self.contentView.height)
            self.foodTwoIcon.frame = CGRect.init(x: iconWidth, y: 0, width: iconWidth, height: self.contentView.height)
            self.foodThreeIcon.frame = CGRect.init(x: iconWidth * 2, y: 0, width: iconWidth, height: self.contentView.height)
        }
    }
}
