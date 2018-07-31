//
//  MyRecipesTableViewCell.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/18/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
//Mark Properties
    
    @IBOutlet weak var RecipesNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var RecipesDescription: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
