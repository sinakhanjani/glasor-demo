//
//  TermikChartViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/11/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class TermikChartViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doruseBartarCollectionView: UICollectionView!
    @IBOutlet weak var darsNameLabel: UILabel!
    
    var termId: ExamTerms?
    
    var exams: GetTableGroup? {
        didSet {
            let data = Array((self.exams?.better.reversed())!)
            self.exams?.better = data
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startIndicatorAnimate()
        darsNameLabel.text = termId?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        APIServices.instance.getTableGroup(termId: termId?.termID ?? "", teacherCourse: "") { (status) in
            if status == .success {
                self.exams = APIServices.instance.getTableGroup
            }
            DispatchQueue.main.async {
                self.doruseBartarCollectionView.reloadData()
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
                self.stopIndicatorAnimate()
            }
        }
    }


}

extension TermikChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return exams?.result.count ?? 0
        } else {
            return exams?.better.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "karnameCell", for: indexPath) as! ChartCollectionViewCell
            guard let data = exams?.result[indexPath.row] else { return cell }
            cell.darsNameLabel.text = data.courseTitle
            cell.mianginCelasiLabel.text = data.averageClass
            cell.mianginePayeLabel.text = data.averageBase
            cell.nesbatBeMiangineCelasiLabel.text = "\(data.statusClass.self)".replacingOccurrences(of: "string", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "integer", with: "").replacingOccurrences(of:"\"", with: "")
            cell.nesbateBeMianginePayeLabel.text = data.statusBase
            cell.nomreLabel.text = data.grade
            cell.rotbeDarCelasLabel.text = data.ratingClass
            cell.rotbeDarPayeLabel.text = data.ratingBase
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "termikCell", for: indexPath) as! DoruseBartarCollectionViewCell
            guard let data = exams?.better[indexPath.row] else { return cell }
            cell.darsNameLabel.text = data.title
            if data.typeMark == "1" {
                cell.adadiLabel.text = data.markValue
            } else {
                cell.adadiLabel.text = ""
            }
            cell.scoreImageView.loadImageUsingCache(withUrl: data.mark)
            return cell
            
        }
        
    }
    
    
}
