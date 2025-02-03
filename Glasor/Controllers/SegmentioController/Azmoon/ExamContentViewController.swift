//
//  ExamContentViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ExamContentViewController: UIViewController {
    
    var sample: Exam?
    var pageNumber = 1
    var examId = DataManager.shared.courseId
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VCContent()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DataManager.shared.courseId = ""
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        VCContent()
    }
    
    static func create() -> ExamContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: EXAM_CONTENT_VC_ID) as! ExamContentViewController
    }
    
    func VCContent() {
        //startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getExamList(page: "\(pageNumber)", schoolId: studentDetail.schoolID, studentId: studentDetail.studentID, examId: examId) { (status) in
            self.webServiceAlert(withType: status, escape: { (staus) in
                if status == .success {
                    self.sample = APIServices.instance.examList
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            })
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.stopIndicatorAnimate()
            }
        }
    }
    
}

extension ExamContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample?.examList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EXAM_CELL_ID, for: indexPath) as! ExamTableViewCell
        guard let data = sample?.examList[indexPath.row] else { return UITableViewCell.init(frame: CGRect.zero)}
        cell.courseTitleLabel.text = data.courseTitle
        cell.typeLabel.text = data.typeValue
        cell.dateLabel.text = data.date
        cell.dayTitle.text = data.dayTitle
        cell.timeDo.text = data.timeDo
        cell.dayLabel.text = data.day
        if data.isTerm {
            cell.examCellBackground.image = #imageLiteral(resourceName: "termik")
            cell.timeDo.text = "جزئیات"
            cell.typeLabel.text = "همه ی دروس"
        } else {
            if data.typeValue == "کتبی" {
                cell.examCellBackground.image = #imageLiteral(resourceName: "katbi")
            } else {
                cell.examCellBackground.image = #imageLiteral(resourceName: "shafahi")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = sample?.examList[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        if data.isTerm {
            performSegue(withIdentifier: EXAM_TO_TERMIK_DETAIL, sender: data.termID)
        } else {
            performSegue(withIdentifier: EXAM_TO_DETAIL, sender: data.id)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? UINavigationController {
            if let targetController = destinationNavigationController.topViewController as? ExamDetailViewController {
                targetController.courseID = sender as! String
            } else {
                if let destinationNavigationController = segue.destination as? UINavigationController {
                    if let targetController = destinationNavigationController.topViewController as? TermikDetailViewController {
                        targetController.termikId = sender as! String
                    }
                }
            }
        }
    }
}

