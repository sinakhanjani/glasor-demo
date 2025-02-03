//
//  SchoolHistoryViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class SchoolHistoryViewController: UIViewController {

    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolImageSubLabel: UILabel!
    @IBOutlet weak var schoolHistoryLabel: UILabel!
    var history = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        stopIndicatorAnimate()
    }
    
    
    func updateUI() {
        guard let schoolProfile = APIServices.instance.schoolInfo else { return }
        schoolImageView.loadImageUsingCache(withUrl: schoolProfile.info[0].cover)
        schoolNameLabel.text = schoolProfile.info[0].title
        if history {
            schoolImageSubLabel.text = "تاریخچه مدرسه"
            schoolHistoryLabel.text = schoolProfile.info[0].history
            schoolHistoryLabel.adjustsFontSizeToFitWidth = true
            schoolHistoryLabel.minimumScaleFactor = 0.2
        } else {
            schoolImageSubLabel.text = "عناوین کسب شده"
            schoolHistoryLabel.text = schoolProfile.info[0].titleEarned
            schoolHistoryLabel.adjustsFontSizeToFitWidth = true
            schoolHistoryLabel.minimumScaleFactor = 0.2
        }
        DispatchQueue.main.async {
            self.stopIndicatorAnimate()
        }
    }
}
