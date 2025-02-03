//
//  SchoolProfileViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class SchoolProfileViewController: UIViewController {

    @IBOutlet weak var schoolProfileView: GradientView1!
    @IBOutlet weak var schoolProfileFirstLabel: UILabel!
    @IBOutlet weak var schoolProfileSecondLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactAddress: UILabel!
    @IBOutlet weak var schoolSite: UILabel!
    @IBOutlet weak var schoolTel1: UILabel!
    @IBOutlet weak var schoolTel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webServiceCall()
        startIndicatorAnimate()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelTap))
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(labelTap1))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(labelTap2))
        schoolTel1.addGestureRecognizer(tap)
        schoolTel2.addGestureRecognizer(tap1)
        schoolSite.addGestureRecognizer(tap2)
        // Do any additional setup after loading the view.
    }
    
    @objc func labelTap() {
        let url = URL(string: "tel://\(schoolTel1.text!)")
        UIApplication.shared.open(url!)
    }
    
    @objc func labelTap1() {
        let url = URL(string: "tel://\(schoolTel2.text!)")
        UIApplication.shared.open(url!)
    }
    
    @objc func labelTap2() {
        let url = URL(string: "http://\(schoolSite.text!)")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    
    func webServiceCall() {
        APIServices.instance.getSchoolInfo(schoolId: DataManager.shared.userDatail!.schoolID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.updateUi()
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
    
    func updateUi() {
        navigationBarApeearence()
        guard let schoolProfile = APIServices.instance.schoolInfo else { return }
        schoolProfileView.loadImageUsingCache(withUrl: schoolProfile.info[0].cover)
        schoolProfileFirstLabel.text = schoolProfile.info[0].title
        contactLabel.text = schoolProfile.info[0].telText
        contactAddress.text = schoolProfile.info[0].address
        schoolSite.text = schoolProfile.info[0].website
        var tels = schoolProfile.info[0].tel.components(separatedBy: ",")
        schoolTel1.text = tels[0]
        if tels.indices.contains(1) {
            schoolTel2.text = tels[1]
        }
    }

    @IBAction func schoolProfileButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: SCHOOL_HISTORY_SEGUE, sender: true)
    }
    
    @IBAction func schoolProfileStaffButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func schoolProfileHonorButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: SCHOOL_HONOR_SEGUE, sender: nil)
    }
    
    @IBAction func schoolProfileMedalsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: SCHOOL_HISTORY_SEGUE, sender: false)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SCHOOL_HISTORY_SEGUE {
            if let history = sender as? Bool {
                if let vc = segue.destination as? SchoolHistoryViewController {
                    vc.history = history
                }
            }
        }
    }
    
    
    // not working in android
    @IBAction func schoolProfileMessageButtonPressed(_ sender: Any) {
        
    }
}
