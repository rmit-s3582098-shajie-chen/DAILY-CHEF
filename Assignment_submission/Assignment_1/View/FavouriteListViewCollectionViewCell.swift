//
//  FavouriteListViewCollectionViewCell.swift
//  Assignment_1
//
//  Created by shajie chen on 2018/1/22.
//  Copyright © 2018年 Shajie Chen. All rights reserved.
//

import UIKit

class FavouriteListViewCollectionViewCell: UICollectionViewCell {
    //MARK: define the variable.
    var foodIcon: UIImageView!
    var nameIcon: UIImageView!
    var descriptionIcon: UIImageView!
    var nameTipLabel: UILabel!
    var nameLabel: UILabel!
    var descriptionTipLabel: UILabel!
    var descriptionLabel: UILabel!
    //MARK: create the reciipe
    var recipe:Recipe?{
        didSet{
            self.foodIcon.image = UIImage(named: (recipe?.photo)!)
            self.nameLabel.text = recipe!.name
            self.descriptionLabel.text = recipe!.recipeDescription
            self.setNeedsLayout()
        }
    }
    //MARK: initilation of the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.foodIcon = UIImageView.init()
        self.foodIcon.image = UIImage.init(named: "breakfast")
        self.contentView.addSubview(self.foodIcon)
        
        self.nameIcon = UIImageView.init(image: UIImage.init(named: "icons8-food-filled-26"))
        self.contentView.addSubview(self.nameIcon)
        
        self.descriptionIcon = UIImageView.init(image: UIImage.init(named: "icons8-rice-bowl-26"))
        self.contentView.addSubview(self.descriptionIcon)
        
        self.nameTipLabel = UILabel.init()
        self.nameTipLabel.text = "Recipe Name:"
        self.contentView.addSubview(self.nameTipLabel)

        self.nameLabel = UILabel.init()
        self.nameLabel.numberOfLines = 0
        self.nameLabel.text = "chicken and brococoli stirfry"
        self.contentView.addSubview(self.nameLabel)
        
        self.descriptionTipLabel = UILabel.init()
        self.nameTipLabel.text = "Description:"
        self.contentView.addSubview(self.descriptionTipLabel)
        
        self.descriptionLabel = UILabel.init()
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.text = "chicken and brococoli stirfry chicken and brococoli stirfry"
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: create the general layout of the cell
    override func layoutSubviews() {
        super.layoutSubviews()
        self.foodIcon.frame = CGRect.init(x: 0, y: 0, width: self.contentView.width, height: 250)
        self.nameIcon.frame = CGRect.init(x: 10, y: self.foodIcon.height + 5, width: 26, height: 26)
        self.descriptionIcon.frame = CGRect.init(x: 10, y: self.nameIcon.bottom + 5, width: 26, height: 26)
        
        self.nameTipLabel.sizeToFit()
        self.nameTipLabel.frame = CGRect.init(x: self.nameIcon.right + 5, y: self.nameIcon.top, width: self.nameTipLabel.width, height: self.nameTipLabel.height)
        
        self.nameLabel.sizeToFit()
        self.nameLabel.frame = CGRect.init(x: self.nameTipLabel.right + 5, y: self.nameIcon.top, width: self.nameLabel.width, height: self.nameLabel.height)
        
        self.descriptionTipLabel.sizeToFit()
        self.descriptionTipLabel.frame = CGRect.init(x: self.nameIcon.right + 5, y: self.descriptionIcon.top, width: self.descriptionTipLabel.width, height: self.descriptionTipLabel.height)

        self.descriptionLabel.sizeToFit()
        self.descriptionLabel.frame = CGRect.init(x: self.descriptionTipLabel.right + 5, y: self.descriptionIcon.top, width: self.contentView.frame.width - 20, height: 60)
    }
}
