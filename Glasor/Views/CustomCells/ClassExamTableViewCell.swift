//
//  ClassExamTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/27/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class ClassExamTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


