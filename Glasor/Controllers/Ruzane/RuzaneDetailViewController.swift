//
//  RuzaneDetailViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/8/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class RuzaneDetailViewController: UIViewController {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        guard let studentDetail = DataManager.shared.userDatail else { return }
        startIndicatorAnimate()
        APIServices.instance.getDailyItemsDetail(DailyStudentId: id, page: "1", schoolId: studentDetail.schoolID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    guard let detail = APIServices.instance.dailyDetail?.result[0] else { return }
                    self.subTitleLabel.text = detail.type
                    self.titleLabel.text = detail.title
                    self.dateLabel.text = detail.cdate
                    self.creatorLabel.text = detail.teacherName
                    self.classLabel.text = detail.courseTitle
                    self.descriptionLabel.text = detail.description
                }
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                }
            })
        }
    }


}
