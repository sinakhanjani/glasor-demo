//
//  WeekTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/26/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var timeDoLabel: UILabel!
    @IBOutlet weak var ringTitleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var expandingHeightConstant: NSLayoutConstraint!
    var cellHeight: CGFloat = 103
    var homeWorkId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
