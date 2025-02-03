//
//  TermikTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/8/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class TermikTableViewCell: UITableViewCell {

    @IBOutlet weak var termTitleLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeDoLabel1: UILabel!
    @IBOutlet weak var timeDoLabel2: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var cellHeight: CGFloat = 40
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
