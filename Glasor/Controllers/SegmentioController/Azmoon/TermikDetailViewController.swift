//
//  TermikDetailViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/8/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class TermikDetailViewController: UIViewController {

    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var termikId = ""
    var termik: TermList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        // Do any additional setup after loading the view.
    }
    
    func updateUi() {
        backBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 16)!], for: .normal)
        backBarButton.tintColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getTermResult(page: "1", schoolId: studentDetail.schoolID, studentId: studentDetail.studentID, termId: termikId) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                   self.termik = APIServices.instance.termList
                    self.tableView.reloadData()
                }
            })
        }
    }
    

    @IBAction func backBarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension TermikDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termik?.terms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TERMIK_CELL_ID, for: indexPath) as! TermikTableViewCell
        guard let term = self.termik?.terms[indexPath.row] else { return UITableViewCell.init(frame: CGRect.zero) }
        cell.termTitleLabel.text = term.termTitle
        cell.courseTitleLabel.text = term.courseTitle
        cell.dateLabel.text = term.date
        cell.descriptionLabel.text = term.description
        cell.timeDoLabel1.text = term.timeDo.components(separatedBy: "-").first!
        cell.timeDoLabel2.text = term.timeDo.components(separatedBy: "-").last!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TermikTableViewCell
        tableView.beginUpdates()
        if cell.cellHeight == 40 {
            UIView.animate(withDuration: 0.5) {
                cell.arrowImageView.transform = cell.arrowImageView.transform.rotated(by: CGFloat.pi)
            }
            cell.cellHeight = 225
        } else {
            UIView.animate(withDuration: 0.5) {
                cell.arrowImageView.transform = cell.arrowImageView.transform.rotated(by: CGFloat.pi)
            }
            cell.cellHeight = 40
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? TermikTableViewCell {
            return cell.cellHeight
        }
        return 40
    }
    
    
}
