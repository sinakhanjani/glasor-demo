//
//  TeacherTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var typeSelection: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        typeSelection.adjustsFontSizeToFitWidth = true
        typeSelection.minimumScaleFactor = 0.2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
