//
//  HomeWorkViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class HomeWorkViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var page = "1"
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarApeearence()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        updateUi()
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        updateUi()
    }
    
    func updateUi() {
        startIndicatorAnimate()
        guard let userInfo = DataManager.shared.userDatail else { return }
        APIServices.instance.getHomeWorkList(page: page, schoolId: userInfo.schoolID, baseId: userInfo.baseID , studentId: userInfo.studentID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.tableView.reloadData()
                }
                self.refreshControl.endRefreshing()
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }

}

extension HomeWorkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIServices.instance.homeWorkList?.work.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HOME_WORK_CELL_ID, for: indexPath) as! HomeWorkTableViewCell
        guard let homeWork = APIServices.instance.homeWorkList?.work else { return UITableViewCell.init(frame: CGRect.zero) }
        cell.courseTitle.text = homeWork[indexPath.row].courseTitle
        cell.titleLabel.text = homeWork[indexPath.row].title
        cell.dayLabel.text = homeWork[indexPath.row].day
        cell.dayTitleLabel.text = homeWork[indexPath.row].dayTitle
        cell.typeDeliveryLabel.text = homeWork[indexPath.row].typeDelivery
        if homeWork[indexPath.row].seen == "0" {
            cell.seenImageView.image = #imageLiteral(resourceName: "ic_homweork_see_32")
        } else {
            cell.seenImageView.image = #imageLiteral(resourceName: "ic_homweork_seen_32")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let homeWork = APIServices.instance.homeWorkList?.work else { return }
        performSegue(withIdentifier: HOMEWORK_TO_DETAIL_SEGUE, sender: homeWork[indexPath.row].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HomeWorkDetailViewController {
            vc.homeWorkId = sender as! String
        }
    }
}
