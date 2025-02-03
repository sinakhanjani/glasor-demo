//
//  HomeWorkTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class HomeWorkTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var typeDeliveryLabel: UILabel!
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var seenImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
