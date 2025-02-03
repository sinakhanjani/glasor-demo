//
//  AssesmentViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/8/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit
import Charts
import DropDown

class AssesmentViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var azmooneTermiLabel: UILabel!
    @IBOutlet weak var azmoonCelassiLabel: UILabel!
    let months: [(index: Int, name: String)] = [(1,"فروردین"),(2,"اردیبهشت"),(3,"خرداد"),(4,"تیر"),(5,"مرداد"),(6,"شهریور"),(7,"مهر"),(8,"آبان"),(9,"آذر"),(10,"دی"),(11,"بهمن"),(12,"اسفند")]
    
    private let dateDropButton = DropDown()
    
    var charts: GetCharts? {
        didSet {
            DispatchQueue.main.async {
                if self.charts?.exam.first?.notifyAssessmentTerm == "0" {
                    self.azmooneTermiLabel.isHidden = true
                    
                } else {
                    self.azmooneTermiLabel.isHidden = false
                    self.azmooneTermiLabel.text = self.charts?.exam.first?.notifyAssessmentTerm
                }
                if self.charts?.exam.first?.notifyAssessmentClass == "0" {
                    self.azmoonCelassiLabel.isHidden = true
                    
                } else {
                    self.azmoonCelassiLabel.isHidden = false
                    self.azmoonCelassiLabel.text = self.charts?.exam.first?.notifyAssessmentClass
                }
            }
        }
    }
    
    @IBOutlet weak var chartCollectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var chartCollectionViewSource = ChartCollectionView()
//    var tableSingle: [TableSingleResult]?
    var inputs = [(x: Double, y: Double, xName: String, yName: String)]()
    
    var monthID = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateDropButton.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
        updateUI()
        chartCollectionView.delegate = chartCollectionViewSource
        chartCollectionView.dataSource = chartCollectionViewSource
        preLoadDropDown()
        navigationBarApeearence()
    }
    
//    func configureDraw() {
//        var indexPath = [IndexPath]()
//        for index in 0..<inputs.count {
//            indexPath.append(IndexPath(row: index, section: 0))
//        }
//        for index in 0..<inputs.count {
//            if index != inputs.count - 1 {
//                chartCollectionView.drawLineFrom(from: indexPath[index], to: indexPath[index + 1], lineWidth: 1, strokeColor: .black)
//            }
//        }
//    }

    func addToChart() {
        if let tableSingle = self.charts?.exam {
            self.inputs = []
            for single in tableSingle {
                let input:(x: Double, y: Double, xName: String, yName: String) = (x: 0.0, y: Double(single.groupCount) ?? 0.0, xName: single.courseTitle, yName: "")
                inputs.append(input)
            }
            self.chartCollectionViewSource.inputs = inputs
            self.chartCollectionViewSource.rotate = false
            self.chartCollectionView.reloadData()
            self.chartCollectionView.scrollToItem(at: IndexPath.init(row: self.inputs.count - 1, section: 0), at: .right, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                self.configureDraw()
                self.chartCollectionView.scrollToItem(at: IndexPath.init(row: self.inputs.count - 1, section: 0), at: .right, animated: true)
            }
        }
    }
    
    func preLoadDropDown() {
        monthButton.setTitle(months[0].name, for: .normal)
        let monthsDataSource = months.map({ $0.name })
        dateDropButton.anchorView = monthButton
        dateDropButton.dataSource = monthsDataSource
        dateDropButton.selectionAction = {(index , item) in
            self.monthButton.setTitle(item, for: .normal)
            self.monthID = "\(self.months[index].index)"
            self.updateUI()
        }
            
    }
    
    func updateUI() {
        startIndicatorAnimate()
        APIServices.instance.getCharts(startMonth: monthID) { (status) in
            if status == .success {
                self.charts = APIServices.instance.getCharts
                DispatchQueue.main.async {
                    self.tableViewHeight.constant = 60 * CGFloat(self.charts?.examShortcut.count ?? 0)
                    self.tableView.reloadData()
                    self.addToChart()
                }
            }
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
    

    @IBAction func azmoonTermikButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "assesmentToTerm", sender: nil)
    }
    
    @IBAction func azmoonClassButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "assestToAzmoonCellasi", sender: nil)
    }
    
    @IBAction func monthButtonPressed(_ sender: Any) {
        dateDropButton.show()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? KarnameViewController {
            vc.exam = sender as! ExamShortcut
        }
    }
}

extension AssesmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts?.examShortcut.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assesmentCell", for: indexPath) as! AssesmentTableViewCell
        guard let exam = charts?.examShortcut[indexPath.row] else { return cell }
        cell.dateLabel.text = exam.dateDo
        cell.nameLabel.text = exam.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let exam = charts?.examShortcut[indexPath.row] else { return }
        performSegue(withIdentifier: "assesToChart", sender: exam)
    }
    
}
