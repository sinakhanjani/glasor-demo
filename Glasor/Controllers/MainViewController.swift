//
//  MainViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import SideMenuController

class MainViewController: UIViewController, SideMenuControllerDelegate {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var popUpViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentClassNumber: UILabel!
    //..........................................
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    //..........................................
    @IBOutlet weak var newsImageView: GradientView1!
    @IBOutlet weak var newsHeaderLabel: UILabel!
    @IBOutlet weak var newsViewsCount: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    //..........................................
    @IBOutlet weak var schoolImageView: GradientView2!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classSubLabel: UILabel!
    //...................
    @IBOutlet weak var collectioView: UICollectionView!
    //...................
    
    @IBOutlet weak var takalifNumberLabel: UILabel!
    @IBOutlet weak var azmoonNumberLabel: UILabel!
    @IBOutlet weak var newsNumberLabel: UILabel!
    @IBOutlet weak var mavaredeRuzaneNumberLabel: UILabel!
    
    
    @IBOutlet weak var popUpNewsView: UIView!
    @IBOutlet weak var popUpMavaredeRuzane: UIView!
    @IBOutlet weak var popUpAzmoonView: UIView!
    @IBOutlet weak var popUpTaklifView: UIView!
    
    
    @IBOutlet weak var popUpTaklifNamesLabel: UILabel!
    @IBOutlet weak var popUpAzmoonNameLabel: UILabel!
    @IBOutlet weak var popUpNewsNameLabel: UILabel!
    
    @IBOutlet weak var popUpMavaredRuzaneLabel: UILabel!
    
    @IBOutlet weak var popUpTaklifImageView: UIImageView!
    @IBOutlet weak var popUpAzmoonImageView: UIImageView!
    @IBOutlet weak var popUpNewsImageView: UIImageView!

    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var popUpMavaredeRuzaneImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let refreshControl = UIRefreshControl()

    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        //
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APIServices.instance.getLoad { (_) in
            //
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatorAnimate()
        sideMenuController?.delegate = self
        updateUI()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        updateUI()
    }
    
    

    @IBAction func classCalenderButtonPressed(_ sender: UIButton) {
        
    }
    
    func updateUI() {
        navigationBarApeearence()
        collectioView.semanticContentAttribute = .forceRightToLeft
        guard let userDetail = DataManager.shared.userDatail else { return }
        profileImageView.loadImageUsingCache(withUrl: userDetail.logo)
        studentNameLabel.text = userDetail.fName + " " + userDetail.lName
        studentClassNumber.text = userDetail.classTitle
        print(userDetail)
        APIServices.instance.getMain(schoolId: userDetail.schoolID, studentId: userDetail.studentID, classId: userDetail.baseID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.collectioView.reloadData()
                    self.updateSchoolUI()
                    self.refreshControl.endRefreshing()
                    self.stopIndicatorAnimate()
                }
            })
        }
    }
    
    func updateSchoolUI() {
        guard let schoolInfo = APIServices.instance.main else { return }
        //......................
        dateDayLabel.text = schoolInfo.day
        dateMonthLabel.text = schoolInfo.month
        //....................
        newsImageView.loadImageUsingCache(withUrl: schoolInfo.newsLogo)
        newsDateLabel.text = schoolInfo.newsDate
        newsViewsCount.text = schoolInfo.newsVisit
        newsHeaderLabel.text = schoolInfo.newTitle
        //....................
        schoolImageView.loadImageUsingCache(withUrl: schoolInfo.schoolCover)
        classNameLabel.text = schoolInfo.schoolTitle
        if schoolInfo.week.count == 0 {
            collectionViewHeight.constant = 0
        } else {
            collectionViewHeight.constant = 82
        }
        //.................
        if schoolInfo.notify.count == 0 {
            if stackView != nil {
                stackView.removeFromSuperview()
                popUpTaklifView.alpha = 0
                popUpAzmoonView.alpha = 0
                popUpNewsView.alpha = 0
                popUpMavaredeRuzane.alpha = 0
            }
        } else {
            popUpTaklifView.alpha = 0
            popUpAzmoonView.alpha = 0
            popUpNewsView.alpha = 0
            popUpMavaredeRuzane.alpha = 0
            for notifi in schoolInfo.notify {
                if notifi.type == "homework" {
                    popUpTaklifImageView.loadImageUsingCache(withUrl: notifi.icon)
                    popUpTaklifNamesLabel.text = notifi.title
                    takalifNumberLabel.text = "\(notifi.counter)".components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    popUpTaklifView.alpha = 1
                } else if notifi.type == "exam" {
                    popUpAzmoonImageView.loadImageUsingCache(withUrl: notifi.icon)
                    popUpAzmoonNameLabel.text = notifi.title
                    azmoonNumberLabel.text = "\(notifi.counter)".components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    popUpAzmoonView.alpha = 1
                } else if notifi.type == "news" {
                    popUpNewsImageView.loadImageUsingCache(withUrl: notifi.icon)
                    popUpNewsNameLabel.text = notifi.title
                    newsNumberLabel.text = "\(notifi.counter)".components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    popUpNewsView.alpha = 1
                } else if notifi.type == "assessment" {
                    popUpMavaredeRuzaneImageView.loadImageUsingCache(withUrl: notifi.icon)
                    popUpMavaredRuzaneLabel.text = notifi.title
                    mavaredeRuzaneNumberLabel.text = "\(notifi.counter)".components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    popUpMavaredeRuzane.alpha = 1
                }
            }
        }
    }
    
    
    @IBAction func newsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: MAIN_TO_NEWS, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewsDetailViewController {
            vc.newsID = APIServices.instance.main!.newsid
        }
    }
    
    @IBAction func popUpNewsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func popUpAzmoonButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func popUpTaklifButtonPressed(_ sender: Any) {
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return APIServices.instance.main?.week.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAIN_COLLECTION_CELL_ID, for: indexPath) as! MainCollectionViewCell
         guard let schoolInfo = APIServices.instance.main else { return UICollectionViewCell.init(frame: CGRect.zero) }
        cell.classNameLabel.text = schoolInfo.week[indexPath.row].schoolCourseTitle
        cell.classTimeLabel.text = schoolInfo.week[indexPath.row].timeDo
        
        return cell
    }
    
    
}
