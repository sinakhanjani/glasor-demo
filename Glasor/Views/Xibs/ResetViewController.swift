//
//  ResetViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/29/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var acceptPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate(duration: 0.25)
        let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 23, height: 10))
        let spacerView1 = UIView(frame:CGRect(x: 0, y: 0, width: 23, height: 10))
        passTextField.rightViewMode = UITextField.ViewMode.always
        passTextField.rightView = spacerView
        acceptPassTextField.rightViewMode = UITextField.ViewMode.always
        acceptPassTextField.rightView = spacerView1
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        guard let code = passTextField.text else { return }
        guard code != "" else { presentWarningAlert(message: "لطفا فیلد ها را پر کنید") ; return }
        guard let pass = acceptPassTextField.text else { return }
        guard pass != "" else { presentWarningAlert(message: "لطفا فیلد ها را پر کنید") ; return }
        APIServices.instance.doPassword(password: pass, smsCode: code) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.presentWarningAlert(message: "تغییر رمز با موفقیت انجام شد")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.presentWarningAlert(message: "رمز وارد شده اشتباه هست")
                }
            })
        }
    }
}
