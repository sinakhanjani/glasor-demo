//
//  ContactTableViewCell.swift
//  SearchExample
//
//  Created by Sinakhanjani on 2/6/1398 AP.
//  Copyright © 1398 iPersianDeveloper. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCell(nameLabel: String, className: String) {
        self.nameLabel.text = nameLabel
        self.classNameLabel.text = className
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
