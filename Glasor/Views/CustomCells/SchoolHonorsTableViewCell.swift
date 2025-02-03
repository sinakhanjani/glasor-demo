//
//  SchoolHonorTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class SchoolHonorsTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
