//
//  TermikAzmoonViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/9/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class TermikAzmoonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var termik: GetExamTerm?
    
    
    override func viewWillAppear(_ animated: Bool) {
        startIndicatorAnimate()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarApeearence()
    }

    func updateUI() {
        APIServices.instance.getExamTerm { (status) in
            if status == .success {
                self.termik = APIServices.instance.getExamTerm
            }
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            }
        }
    }
}

extension TermikAzmoonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termik?.exam.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "termikCell", for: indexPath) as! TermikExamTableViewCell
        guard let exam = termik?.exam[indexPath.row] else { return cell }
        cell.dateLabel.text = exam.dateDo
        cell.nameLabel.text = exam.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let termID = termik?.exam[indexPath.row] else { return }
        performSegue(withIdentifier: "azmoonToChart", sender: termID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TermikChartViewController {
            vc.termId = sender as! ExamTerms
        }
    }
    
    
}
