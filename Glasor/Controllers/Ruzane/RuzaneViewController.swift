//
//  RuzaneViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/8/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class RuzaneViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dailyItems: DailyItems?
    var page = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let data = DataManager.shared
        data.courseId = ""
        data.teacherId = ""
        data.startMonth = ""
        data.endMoth = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dailyItems = nil
        updateUI()
    }
    
    func updateUI() {
        self.navigationBarApeearence()
        self.startIndicatorAnimate()
        let data = DataManager.shared
        guard let studentDetail = data.userDatail else { return }
        print("teacherID =" , data.teacherId)
        print("teacherCourse = ", data.teacherCourse)
        APIServices.instance.getDailyItemsStudent(page: page, teacherId: data.teacherId , teacherCourse: data.teacherCourse, startMonth: data.startMonth, endMonth: data.endMoth, studentId: studentDetail.studentID, schoolId: studentDetail.schoolID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    guard let daily = APIServices.instance.dailyItems else { return }
                    self.dailyItems = daily
                    self.tableView.reloadData()
                }
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                }
            })
        }
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "dailySearch")
        present(vc!, animated: true, completion: nil)
    }
    
}

extension RuzaneViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyItems?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DAILY_CELL_ID, for: indexPath) as! DailyItemsTableViewCell
        guard let daily = self.dailyItems?.result[indexPath.row] else { return UITableViewCell.init() }
        cell.cdateLabel.text = daily.cdate
        cell.fullNameLabel.text = daily.fullName
        cell.typeLabel.text = daily.type
        cell.titleLabel.text = daily.title
        if daily.type == "منفی انضباطی" {
            cell.backgroundImageView.image = #imageLiteral(resourceName: "manfi")
        } else {
            cell.backgroundImageView.image = #imageLiteral(resourceName: "mosbat")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = dailyItems?.result[indexPath.row].id else { return }
        performSegue(withIdentifier: DAILY_TO_DETAIL, sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RuzaneDetailViewController {
            vc.id = sender as! String
        }
    }
}
