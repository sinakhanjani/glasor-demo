//
//  ResetPasswordViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var meliCodeTextView: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate(duration: 0.25)
        configureTouchXibViewController(bgView: bgView)
        let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 23, height: 10))
        meliCodeTextView.rightViewMode = UITextField.ViewMode.always
        meliCodeTextView.rightView = spacerView

    }

    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
        guard meliCodeNumberCondition(phoneNumber: meliCodeTextView.text ?? "") else { return }
        APIServices.instance.userGetPassword(meliCode: meliCodeTextView.text!) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.presentResetViewController()
                }
            })
        }
    }
    

}
