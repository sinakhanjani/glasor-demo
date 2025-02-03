//
//  CollectionViewCell.swift
//  Glasor
//
//  Created by Sinakhanjani on 2/3/1398 AP.
//  Copyright © 1398 Teodik Abrami. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var xNameLabel: UILabel!
    @IBOutlet weak var circleView: RoundedView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

