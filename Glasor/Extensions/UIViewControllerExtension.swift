//
//  UIViewControllerExtension.swift
//  FerFere
//
//  Created by Teodik Abrami on 10/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
import UIKit
//import SideMenu
import CDAlertView
//import Lottie
//import SwiftSVG

extension UIViewController {
    
    func webServiceAlert(withType type: Alert, escape: @escaping COMPLETION_HANDLER) {
        DispatchQueue.main.async {
            switch type {
            case .none:
                self.stopIndicatorAnimate()
                print("Alert Type: none")
                break
            case .success:
                print("Alert Type: success")
                escape(.success)
            case .failed:
                self.stopIndicatorAnimate()
                print("Alert Type: failed")
                let message = " !خطا در برقرارای ارتباط با سرور"
                self.presentWarningAlert(message: message)
            case .server:
                self.stopIndicatorAnimate()
                print("Alert Type: server")
                //let message = "اطلاعات از سرور کاریو دریافت نشد !"
                let message = "اطلاعات از سرور دریافت نشد"
                self.presentWarningAlert(message: message)
            case .network:
                self.stopIndicatorAnimate()
                print("Alert Type: network")
                let message = "ارتباط شما با اینترنت قطغ میباشد !"
                self.presentWarningAlert(message: message)
            case .invalidInput:
                self.stopIndicatorAnimate()
                print("Alert Type: invalid Input textField")
                let message = "لطفا اطلاعات ورودی را بررسی نمایید"
                self.presentWarningAlert(message: message)
            case .duplicate:
                self.stopIndicatorAnimate()
                print("Alert Type: duplicate in server")
                let message = "با این شماره قبلا ثبت نام کرده اید، لطفا گزینه ورود را انتخاب کنید !"
                self.presentWarningAlert(message: message)
            case .json:
                self.stopIndicatorAnimate()
                print("Alert Type: json")
            case .data:
                self.stopIndicatorAnimate()
                print("Alert Type: data")
            case .noLogin:
                self.stopIndicatorAnimate()
                print("Alert Type: noLogin")
                let message = "این شماره قبلا در سیستم ثبت است، لطفا مجددا تلاش کنید !"
                self.presentWarningAlert(message: message)
            case .wrongCode:
                self.stopIndicatorAnimate()
                print("Alert Type: wringCode")
                let message = "کد تایید را اشتباه وارد کرده اید !"
                self.presentWarningAlert(message: message)
            case .noData:
                print("Alert Type: no Data")
            }
        }
    }
    
    
}


extension UIViewController {
    
    // ViewControllers
    func dismissesKeyboardByTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchPressed))
        self.view.addGestureRecognizer(touch)
         touch.cancelsTouchesInView = false
    }
    
    @objc func touchPressed() {
        self.view.endEditing(true)

    }
    
    // Xibs ViewController
    func configureTouchXibViewController(bgView: UIView) {
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissTouchPressed))
        bgView.addGestureRecognizer(touch)
    }
    
    @objc func dismissTouchPressed() {
        removeAnimate(duration: 0.25)
    }
    
    
    
}



extension UIViewController {
    
    func presentWarningAlert(message: String) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        alert.messageFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        let cancel = CDAlertViewAction(title: "باشه", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: cancel)
        alert.show()
    }
    
    func presentIsNotLoggedInAlert() {
        let alert = CDAlertView(title: "توجه", message: "دسترسی به این بخش نیازمند ثبت نام می باشد", type: CDAlertViewType.notification)
        alert.titleFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        alert.messageFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        let cancel = CDAlertViewAction(title: "بعدا", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        let register = CDAlertViewAction(title: "ثبت نام", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: REGISTURE_USER_ID)
          //  self.present(vc!, animated: true, completion: nil)
            return true
        }
        alert.add(action: cancel)
        alert.add(action: register)
        alert.show()
    }
    
    func presentDeleteAccountAlert() {
        let alert = CDAlertView(title: "توجه", message: "آیا از حذف حساب کاربری خود مطمئن هستید؟", type: CDAlertViewType.notification)
        alert.titleFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        alert.messageFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        let cancel = CDAlertViewAction(title: "خیر", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        let register = CDAlertViewAction(title: "بلی", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
          //  Authentication.auth.logOutAuth()
            self.dismiss(animated: true, completion: nil)
            return true
        }
        alert.add(action: cancel)
        alert.add(action: register)
        alert.show()
    }
    
    func presentDeleteAddressAlert() {
        let alert = CDAlertView(title: "توجه", message: "آیا از حذف آدرس مطمئن هستید؟", type: CDAlertViewType.notification)
        alert.titleFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        alert.messageFont = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        let cancel = CDAlertViewAction(title: "خیر", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        let register = CDAlertViewAction(title: "بلی", font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14), textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
           // NotificationCenter.default.post(name: ADDRESS_DELETED, object: nil)
            return true
        }
        alert.add(action: cancel)
        alert.add(action: register)
        alert.show()
    }
    
    func meliCodeNumberCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            let message = "شماره ملی خالی میباشد!"
            presentWarningAlert(message: message)
            return false
        }
        guard number.count >= 10 || number.count <= 15 else {
            let message = "شماره ملی میبایست بین ۱۰ تا ۱۵ رقم باشد"
            presentWarningAlert(message: message)
            return false
        }
        
        return true
    }
    
    func navigationBarApeearence() {
        let backButton = UIBarButtonItem(title: "بازگشت", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)!], for: .normal)
        backButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.backBarButtonItem = backButton
    }
    
}

extension UIViewController {
    
    func showAnimate(duration: Double) {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate(duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { (finished) in
            if finished {
                self.view.removeFromSuperview()
            }
        }
    }
    
}

extension UIViewController {
    
    func startIndicatorAnimate() {
        let indicatorVC = IndicatorViewController()
        self.addChild(indicatorVC)
        indicatorVC.view.frame = self.view.frame
        self.view.addSubview(indicatorVC.view)
        indicatorVC.didMove(toParent: self)
    }
    
    func startIndicatorAnimate1() {
        let indicatorVC = IndicatorViewController()
        self.addChild(indicatorVC)
        indicatorVC.view.frame = self.view.frame
        self.view.addSubview(indicatorVC.view)
        indicatorVC.didMove(toParent: self)
    }
    
    func stopIndicatorAnimate() {
        NotificationCenter.default.post(name: DISMISS_INDICATOR_VC_NOTIFY, object: nil)
    }
    
}

// Xibs Present Controller
extension UIViewController {
    
    func presentResetPasswordViewController() {
        let resetPasswordViewController = ResetPasswordViewController()
        self.addChild(resetPasswordViewController)
        resetPasswordViewController.view.frame = self.view.frame
        self.view.addSubview(resetPasswordViewController.view)
        resetPasswordViewController.didMove(toParent: self)
    }
    
    func presentResetViewController() {
        let resetViewController = ResetViewController()
        self.addChild(resetViewController)
        resetViewController.view.frame = self.view.frame
        self.view.addSubview(resetViewController.view)
        resetViewController.didMove(toParent: self)
    }

    
}



