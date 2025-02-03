//
//  ResultContentViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ResultContentViewController: UIViewController {

    var sample: ExamResult?
    @IBOutlet weak var tabelView: UITableView!
    var pageNumber = 1
    var courseID = DataManager.shared.courseId
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        VCContent()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tabelView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         DataManager.shared.courseId = ""
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        VCContent()
    }
    
    static func create() -> ResultContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: RESULT_CONTENT_VC_ID) as! ResultContentViewController
    }
    
    func VCContent() {
       // startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getExamResult(page: "\(pageNumber)", schoolId: studentDetail.schoolID, studentId: studentDetail.studentID, courseId: courseID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.sample = APIServices.instance.examResult
                    self.tabelView.reloadData()
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

extension ResultContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RESULT_CELL_ID, for: indexPath) as! ResultTableViewCell
        guard let data = sample?.result[indexPath.row] else { return UITableViewCell.init(frame: CGRect.zero)}
        cell.dayLabel.text = data.day
        cell.dayTitleLabel.text = data.dayTitle
        cell.courseTitleLabel.text = data.courseTitle
        cell.typeValueLabel.text = data.typeValue
        cell.resultImageView.loadImageUsingCache(withUrl: data.mark)
        if data.typeMark == "1" {
            cell.adadiLabel.text = data.markValue
        } else {
            cell.adadiLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = sample?.result[indexPath.row] else { return }
        performSegue(withIdentifier: RESULT_TO_DETAIL, sender: data.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? UINavigationController {
            let targetController = destinationNavigationController.topViewController as! ExamDetailViewController
            targetController.examId = sender as! String
        }
    }
}
