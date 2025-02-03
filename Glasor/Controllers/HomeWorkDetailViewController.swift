//
//  HomeWorkDetailViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class HomeWorkDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var darsNameLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var deliveryTypeLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var tozihatLabel: UILabel!
    var homeWorkId = "0"
        
    //...................
    @IBOutlet weak var fileLabel: UILabel!
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var fileButtonView: RoundedButton!
    //.....................
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        startIndicatorAnimate()
        guard let userInfo = DataManager.shared.userDatail else { return }
        APIServices.instance.getHomeWorkDetail(page: "1", schoolId: userInfo.schoolID, baseId: userInfo.baseID, studentId: userInfo.studentID, homeWorkId: self.homeWorkId) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    guard let homeWork = APIServices.instance.homeWorkDetail else { return }
                    self.nameLabel.text = homeWork.work[0].title
                    self.darsNameLabel.text = homeWork.work[0].courseTitle
                    self.deliveryDateLabel.text = homeWork.work[0].expireCdate
                    self.deliveryTypeLabel.text = homeWork.work[0].typeDelivery
                    self.createDateLabel.text = homeWork.work[0].cdate
                    self.tozihatLabel.text = homeWork.work[0].description
                    if homeWork.work[0].attachment == "empty" {
                        self.fileLabel.removeFromSuperview()
                        self.fileImageView.removeFromSuperview()
                        self.fileButtonView.removeFromSuperview()
                    } else {
                        self.fileLabel.isHidden = false
                        self.fileImageView.isHidden = false
                        self.fileButtonView.isHidden = false
                    }
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
    
    @IBAction func fileOpenButtonPressed(_ sender: Any) {
        if APIServices.instance.examDetail?.fileExam != "empty" {
            let url = URL.init(string: (APIServices.instance.homeWorkDetail?.work[0].attachment)!)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
 

}
