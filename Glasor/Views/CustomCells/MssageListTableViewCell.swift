//
//  MssageListTableViewCell.swift
//  Master
//
//  Created by Teodik Abrami on 4/16/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

class MssageListTableViewCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
