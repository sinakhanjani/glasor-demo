//
//  ExamTableViewCell.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ExamTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeDo: UILabel!
    @IBOutlet weak var examCellBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
