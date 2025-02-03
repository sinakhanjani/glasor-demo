//
//  ClassAzmoonViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/9/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class ClassAzmoonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //
    var data: GetExamClass?
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        navigationBarApeearence()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        startIndicatorAnimate()
        APIServices.instance.getExamClass { (status) in
            if status == .success {
                self.data = APIServices.instance.getExamClass
            }
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? KarnameViewController {
            vc.teacherCourse = sender as! Exams
        }
    }
}

extension ClassAzmoonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.exam.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classAzmoonCell", for: indexPath) as! ClassExamTableViewCell
        guard let data = data?.exam[indexPath.row] else { return cell }
        cell.nameLabel.text = data.fullName
        cell.dateLabel.text = data.courseTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = data?.exam[indexPath.row] else { return }
        performSegue(withIdentifier: "classTore", sender: data)
    }
    
    
}
