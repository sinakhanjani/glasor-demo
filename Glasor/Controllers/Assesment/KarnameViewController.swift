//
//  KarnameViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/9/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class KarnameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chartCollectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    var chartCollectionViewSource = ChartCollectionView()
    var tableSingle: [TableSingleResult]?
    var inputs = [(x: Double, y: Double, xName: String, yName: String)]()
    
    var teacherCourse: Exams?
    var exam: ExamShortcut?
    
   // var exams: GetExamTerm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let exam = exam {
            courseNameLabel.text = exam.title
        } else {
           courseNameLabel.text = teacherCourse?.courseTitle
        }
        
        updateUI()
    }
    
    func configureDraw() {
        var indexPath = [IndexPath]()
        for index in 0..<inputs.count {
            indexPath.append(IndexPath(row: index, section: 0))
        }
        for index in 0..<inputs.count {
            if index != inputs.count - 1 {
                chartCollectionView.drawLineFrom(from: indexPath[index], to: indexPath[index + 1], lineWidth: 1, strokeColor: .black)
            }
        }
    }
    
    func updateUI() {
        chartCollectionView.delegate = chartCollectionViewSource
        chartCollectionView.dataSource = chartCollectionViewSource
        self.startIndicatorAnimate()
        
        if let exam = exam {
            APIServices.instance.getTableSingle(teacherCourse: exam.teacherCourse) { (status) in
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    if status == .success {
                        self.tableSingle = APIServices.instance.getTableSingle?.result
                        self.addToChart()
                        self.collectionView.reloadData()
                        self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
                    }
                }
            }
        } else {
            APIServices.instance.getTableSingle(teacherCourse: teacherCourse?.teacherCourse ?? "") { (status) in
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    if status == .success {
                        self.tableSingle = APIServices.instance.getTableSingle?.result
                        self.addToChart()
                        self.collectionView.reloadData()
                        self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
                    }
                }
            }
        }
        
    }
    
    func addToChart() {
        if let tableSingle = self.tableSingle {
            for single in tableSingle {
                let input:(x: Double, y: Double, xName: String, yName: String) = (x: 0.0, y: Double(single.grade) ?? 0.0, xName: single.courseTitle, yName: "")
                inputs.append(input)
            }
            self.chartCollectionViewSource.inputs = inputs
            self.chartCollectionViewSource.rotate = true
            self.chartCollectionView.reloadData()
            self.chartCollectionView.scrollToItem(at: IndexPath.init(row: self.inputs.count - 1, section: 0), at: .right, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.configureDraw()
                self.chartCollectionView.scrollToItem(at: IndexPath.init(row: self.inputs.count - 1, section: 0), at: .right, animated: true)
            }
        }
    }
    
    

}


extension KarnameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableSingle?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "karnameCell", for: indexPath) as! ChartCollectionViewCell
        guard let data = tableSingle?[indexPath.row] else { return cell }
        cell.darsNameLabel.text = data.courseTitle
        cell.mianginCelasiLabel.text = data.averageClass
        cell.mianginePayeLabel.text = data.averageBase
        cell.nesbatBeMiangineCelasiLabel.text = "\(data.statusClass.self)".replacingOccurrences(of: "string", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "double", with: "").replacingOccurrences(of:"\"", with: "")
        cell.nesbateBeMianginePayeLabel.text = "\(data.statusBase.self)".replacingOccurrences(of: "string", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "double", with: "").replacingOccurrences(of:"\"", with: "")
        cell.nomreLabel.text = data.grade
        cell.rotbeDarCelasLabel.text = data.ratingClass
        cell.rotbeDarPayeLabel.text = data.ratingBase
        return cell
        
    }
    
    
}
