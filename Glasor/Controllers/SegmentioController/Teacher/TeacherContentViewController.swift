//
//  TeacherContentViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class TeacherContentViewController: UIViewController {

    var sample: TeacherList?
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        VCContent()
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        VCContent()
    }
    
    func VCContent() {
        startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getTeacher(page: "1", schoolId: studentDetail.schoolID) { (status) in
            if status == .success {
                self.sample = APIServices.instance.teacherList
            }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    static func create() -> TeacherContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: TEACHER_CONTENT_VC_ID) as! TeacherContentViewController
    }

}

extension TeacherContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample?.teachers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TEACHER_CELL, for: indexPath) as! TeacherTableViewCell
        guard let data = sample?.teachers[indexPath.row] else { return UITableViewCell.init(frame: CGRect.zero)}
        cell.profileImageView.loadImageUsingCache(withUrl: data.avatar)
        cell.fullName.text = data.fullName
        cell.typeSelection.text = data.courseTeacher
        return cell
    }
}
