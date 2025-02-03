//
//  ExamDetailViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/28/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ExamDetailViewController: UIViewController {
    
    var courseID = ""
    var examId = ""
    var examOrResult = true
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cdateLabel: UILabel!
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var timeDoLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var viewConstrait: NSLayoutConstraint!
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    //...................
    @IBOutlet weak var fileLabel: UILabel!
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var fileButtonView: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentVC()
        navigate()
        
    }
    
    func navigate() {
        backBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 16)!], for: .normal)
        backBarButton.tintColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func contentVC() {
        startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getExamDetail(page: "1", schoolId: studentDetail.schoolID, studentId: studentDetail.studentID, examId: examId) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    guard let data = APIServices.instance.examDetail  else { return }
                    self.dateLabel.text = data.date
                    self.cdateLabel.text = data.cdate
                    self.typeValueLabel.text = data.typeValue
                    self.courseTitleLabel.text = data.courseTitle
                    self.timeDoLabel.text = data.timeDo
                    self.teacherNameLabel.text = data.teacherFullName
                    self.descriptionLabel.text = data.description
                    if data.fileExam == "empty" {
                        self.fileLabel.isHidden = true
                        self.fileImageView.isHidden = true
                        self.fileButtonView.isHidden = true
                        self.fileLabel.removeFromSuperview()
                        self.fileImageView.removeFromSuperview()
                        self.fileButtonView.removeFromSuperview()
                        // self.viewConstrait.constant = 260
                    } else {
                        self.fileLabel.isHidden = false
                        self.fileImageView.isHidden = false
                        self.fileButtonView.isHidden = false
                        //  self.viewConstrait.constant = 315
                    }
                }
            })
            DispatchQueue.main.async {
                  self.stopIndicatorAnimate()
            }
        }
    }
    
    
    @IBAction func dismissBarButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fileOpenButtonPressed(_ sender: Any) {
        if APIServices.instance.examDetail?.fileExam != "empty" {
            let url = URL.init(string: (APIServices.instance.examDetail?.fileExam)!)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
}

