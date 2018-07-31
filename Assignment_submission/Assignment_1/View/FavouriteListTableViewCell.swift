//
//  FavouriteListTableViewCell.swift
//  Assignment_1
//
//  Created by Shajie Chen on 1/20/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit

class FavouriteListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionText.isEditable = false
        self.photoImageView.layer.cornerRadius = 5
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.clipsToBounds = true
    }
}
