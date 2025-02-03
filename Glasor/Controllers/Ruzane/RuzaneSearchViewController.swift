//
//  RuzaneSearchViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/8/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import DropDown

class RuzaneSearchViewController: UIViewController {

    @IBOutlet weak var fromMonthTextField: UITextField!
    @IBOutlet weak var monthToTextField: UITextField!
    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var courseButton: UIButton!
    
    let months: [(index: Int, name: String)] = [(1,"فروردین"),(2,"اردیبهشت"),(3,"خرداد"),(4,"تیر"),(5,"مرداد"),(6,"شهریور"),(7,"مهر"),(8,"آبان"),(9,"آذر"),(10,"دی"),(11,"بهمن"),(12,"اسفند")]
    
    private let startDateDropButton = DropDown()
    private let endDateDropButton = DropDown()
    private let teacherDropButton = DropDown()
    private let darsDropButton = DropDown()
    var startIndex = 0
    var endIndex = 0
    
    var startDate: String = "" {
        didSet {
            DataManager.shared.startMonth = startDate
        }
    }
    
    var endDate: String = "" {
        didSet {
            DataManager.shared.endMoth = endDate
        }
    }
    
    var teacherID: String = "" {
        didSet {
            print(teacherID)
            DataManager.shared.teacherId = teacherID
        }
    }
    
    var darsID: String = "" {
        didSet {
            print(darsID)
            DataManager.shared.teacherCourse = darsID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissesKeyboardByTouch()
        today()
        startDateDropButton.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
        endDateDropButton.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
        teacherDropButton.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
        darsDropButton.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.darkGray
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.tag = 0
        fromMonthTextField.inputView = pickerView
        fromMonthTextField.inputAccessoryView = toolBar
        
        
        let pickerView1 = UIPickerView()
        pickerView1.delegate = self
        pickerView1.showsSelectionIndicator = true
        pickerView1.tag = 1
        monthToTextField.inputView = pickerView1
        monthToTextField.inputAccessoryView = toolBar
        preLoad()
    }
    
    @objc func donePicker() {
        monthToTextField.resignFirstResponder()
        fromMonthTextField.resignFirstResponder()
    }
    
    func preLoad() {
//        fromMonthButton.setTitle(months[0].name, for: .normal)
//        monthToButton.setTitle(months[0].name, for: .normal)
//        let monthsDataSource = months.map({ $0.name })
//        startDateDropButton.anchorView = fromMonthButton
//        startDateDropButton.dataSource = monthsDataSource
//        startDateDropButton.selectionAction = {(index , item) in
//            self.startDate = item
//            self.fromMonthButton.setTitle(item, for: .normal)
//            self.startIndex = index
//        }
//
//        endDateDropButton.anchorView = monthToButton
//        endDateDropButton.dataSource = monthsDataSource
//        endDateDropButton.selectionAction = { (index, item) in
//            self.endDate = item
//            self.monthToButton.setTitle(item, for: .normal)
//            self.endIndex = index
//        }
        
        
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getTeacherByClass(classID: studentDetail.baseID, schoolId: studentDetail.schoolID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.updateTeachers()
                }
            })
        }
    }
    
    func updateTeachers() {
        guard let teachers = APIServices.instance.dailyTeacher else { return }
        self.teacherDropButton.anchorView = self.teacherButton
        let teacherDataSource = teachers.teacher.map({ $0.fullName })
        teacherButton.setTitle(teacherDataSource[0], for: .normal)
        print(teacherDataSource)
        self.teacherDropButton.dataSource = teacherDataSource
        self.teacherDropButton.selectionAction = { (index, item) in
            self.teacherButton.setTitle(item, for: .normal)
            self.teacherID = teachers.teacher[index].teacherID
            self.updateCourses()
        }
    }
    
    func updateCourses() {
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getCourseByStudent(classID: studentDetail.baseID, schoolId: studentDetail.schoolID, teacherId: self.teacherID, completion: { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    guard let courses = APIServices.instance.courseByTeacher else { return }
                    self.darsDropButton.anchorView = self.courseButton
                    let courseDataSource = courses.course.map({ $0.title })
                    self.courseButton.setTitle(courseDataSource[0], for: .normal)
                    print(courseDataSource)
                    self.darsDropButton.dataSource = courseDataSource
                    self.darsDropButton.selectionAction = { (index, item) in
                        self.courseButton.setTitle(item, for: .normal)
                        self.darsID = courses.course[index].id
                    }
                }
            })
        })
        
    }
    
    @IBAction func teacherButtonPressed(_ sender: Any) {
        teacherDropButton.show()
        darsID = ""
    }
    
    @IBAction func courseButtonPressed(_ sender: Any) {
        guard courseButton.titleLabel?.text != "" else { return }
        darsDropButton.show()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        startDate = ""
        endDate = ""
        darsID = ""
        teacherID = ""
        startIndex = 0
        endIndex = 0
        dismiss(animated: true, completion: nil)
    }
    
    func today() {
        let date = Date()
        var index = 0
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.init(identifier: .persian)
        dateFormatter.dateFormat =  "yyyy/MM/dd"
        dateFormatter.dateFormat = "LLLL"
        let data = dateFormatter.string(from: date)
        switch data {
        case "Farvardin":
            index = 0
        case "Ordibehesht":
            index = 1
        case "Khordad":
            index = 2
        case "Tir":
            index = 3
        case "Mordad":
            index = 4
        case "Shahrivar":
            index = 5
        case "Mehr":
            index = 6
        case "Aban":
            index = 7
        case "Azar":
            index = 8
        case "Dey":
            index = 9
        case "Bahman":
            index = 10
        case "Esfand":
            index = 11
        default:
            break
        }
        let name = months[index]
        fromMonthTextField.text = name.name
        monthToTextField.text = name.name
        startDate = name.name
        endDate = name.name
    }
}

extension RuzaneSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            fromMonthTextField.text = months[row].name
            startDate = months[row].name
        } else {
            monthToTextField.text = months[row].name
            endDate = months[row].name
        }
    }
    
    
}
