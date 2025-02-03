//
//  WeekendContentViewController.swift
//  TEST
//
//  Created by Sinakhanjani on 9/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit



class WeekContentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var index: IndexPath?
    var sample: WeekList?
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarApeearence()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: RELOAD_STOP, object: nil)
    }
    
    @objc func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.stopIndicatorAnimate()
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        NotificationCenter.default.post(name: RELOAD_START, object: nil)
    }
    @IBAction func homeWorkButtonPressed(_ sender: Any) {
        let buttonPosition: CGPoint = (sender as! UIButton).convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        performSegue(withIdentifier: WEEK_TO_HOMEWORK, sender: sample?.toDo[indexPath!.row].courseID)
    }
    
    @IBAction func examButtonPressed(_ sender: Any) {
        let buttonPosition: CGPoint = (sender as! UIButton).convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        performSegue(withIdentifier: WEEK_TO_EXAM, sender: sample?.toDo[indexPath!.row].courseID)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WEEK_TO_EXAM {
            DataManager.shared.courseId = sender as! String
        }
    }
    // Method
    static func create() -> WeekContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: WEEK_CONTENT_VC_ID) as! WeekContentViewController
    }

}

extension WeekContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sample?.toDo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WEEK_CELL, for: indexPath) as! WeekTableViewCell
        guard let data = sample?.toDo else { return UITableViewCell.init(frame: CGRect.zero)}
        cell.courseTitleLabel.text = data[indexPath.row].courseTitle
        cell.fullNameLabel.text = data[indexPath.row].fullName
        cell.timeDoLabel.text = data[indexPath.row].timeDo
        cell.ringTitleLabel.text = data[indexPath.row].ringTitle
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WeekTableViewCell
        tableView.beginUpdates()
        if cell.cellHeight == 103 {
            UIView.animate(withDuration: 0.5) {
                cell.arrowImageView.transform = cell.arrowImageView.transform.rotated(by: CGFloat.pi)
            }
            cell.cellHeight = 190
        } else {
            UIView.animate(withDuration: 0.5) {
                cell.arrowImageView.transform = cell.arrowImageView.transform.rotated(by: CGFloat.pi)
            }
            cell.cellHeight = 103
        }
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? WeekTableViewCell {
            return cell.cellHeight
        }
        return 103
    }
    
   
    
    
    
    
    
}
