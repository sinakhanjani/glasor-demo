//
//  LoginViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        dismissesKeyboardByTouch()
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "کد ملی را درج فرمایید",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "کلمه عبور را درج فرمایید",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 23, height: 10))
        let spacerView1 = UIView(frame:CGRect(x: 0, y: 0, width: 23, height: 10))
        userNameTextField.rightViewMode = UITextField.ViewMode.always
        userNameTextField.rightView = spacerView
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        passwordTextField.rightView = spacerView1
        userNameTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 15
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard meliCodeNumberCondition(phoneNumber: userNameTextField.text ?? "") else { return }
        guard let password = passwordTextField.text else { return }
        guard password != "" else { presentWarningAlert(message: "رمز عبور خود را وارد نمایید") ; return }
        APIServices.instance.loginUser(fcmToken: "tokenFcm", meliCode: userNameTextField.text!, password: password) { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    Authentication.auth.authenticationUser(isLoggedIn: true, userInfo: APIServices.instance.login!)
                    self.performSegue(withIdentifier: LOGIN_TO_MAIN, sender: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.presentWarningAlert(message: "شماره ملی یا رمز عبور اشتباه است")
                }
            }
        }
    }
    
    @IBAction func resetPasswordButtonPressed(_ sender: Any) {
         presentResetPasswordViewController()
    }
    
    
    
}
