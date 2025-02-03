//
//  SchoolHonorsViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class SchoolHonorsViewController: UIViewController {

    @IBOutlet weak var schoolHonorsHeadImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var page = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatorAnimate()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        APIServices.instance.getHonors(page: page, schoolId: DataManager.shared.userDatail!.schoolID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.tableView.reloadData()
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
}

extension SchoolHonorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIServices.instance.honor?.honorResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SCHOOL_HONOR_CELL_ID, for: indexPath) as! SchoolHonorsTableViewCell
        guard let schoolHonors = APIServices.instance.honor?.honorResults else { return UITableViewCell.init(frame: CGRect.zero) }
        cell.personImageView.loadImageUsingCache(withUrl: schoolHonors[indexPath.row].logo)
        cell.rankingLabel.text = schoolHonors[indexPath.row].action
        cell.nameLabel.text = schoolHonors[indexPath.row].title
        return cell
    }
    
    
}
