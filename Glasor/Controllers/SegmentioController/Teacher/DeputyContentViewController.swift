//
//  DeputyContentViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class DeputyContentViewController: UIViewController {

    var sample: DeputyList?
    @IBOutlet weak var tabelView: UITableView!
    
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentVC()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tabelView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        contentVC()
    }
    
    func contentVC() {
        startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getDeputy(page: "1", schoolId: studentDetail.schoolID) { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    self.sample = APIServices.instance.deputyList
                    self.tabelView.reloadData()
                }
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.stopIndicatorAnimate()
            }
        }
    }
    
    static func create() -> DeputyContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: DEPUTY_CONTENT_VC_ID) as! DeputyContentViewController
    }

}

extension DeputyContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample?.deputys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DEPUTY_CELL, for: indexPath) as! DeputyTableViewCell
        guard let data = sample?.deputys[indexPath.row] else { return UITableViewCell.init(frame: CGRect.zero)}
        cell.profileImageView.loadImageUsingCache(withUrl: data.avatar ?? EMPTY_IMAGE)
        cell.fullName.text = data.fullName
        cell.typeSelection.text = data.typeSelect
        return cell
    }
}
