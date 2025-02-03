//
//  ResetPassViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ResetPassViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var acceptPasswordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissesKeyboardByTouch()
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.minimumScaleFactor = 0.2
        
    }

    @IBAction func acceptButtonPressed(_ sender: Any) {
        startIndicatorAnimate()
        guard let pass = passwordLabel.text else { return }
        guard pass != "" else { presentWarningAlert(message: "لطفا فیلد ها را پر کنید") ; return }
        guard let accpass = acceptPasswordLabel.text else { return }
        guard accpass != "" else { presentWarningAlert(message: "لطفا فیلد ها را پر کنید") ; return }
        guard pass == accpass else { presentWarningAlert(message: "رمز ها با هم برابر نیست") ; return }
        guard let student = DataManager.shared.userDatail else { return }
        APIServices.instance.changePassword(studentId: student.studentID, schoolId: student.schoolID, password: pass) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.passwordLabel.text = ""
                    self.acceptPasswordLabel.text = ""
                    self.presentWarningAlert(message: "رمز عبور شما عوض شد.")
                    self.dismiss(animated: true, completion: nil)
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
        
    }
}
