//
//  AssesmentTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/8/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class AssesmentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

