//
//  MessageDetailViewController.swift
//  Master
//
//  Created by Teodik Abrami on 4/16/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit
import CDAlertView

class MessageDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var topBackgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var textInputView: UIView!
    
    var image = UIImage()
        
    let imagePicker = UIImagePickerController()
    
    var dialogId: Dialog?
    var message: [Message]?
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        imagePicker.delegate = self
        tableVIew.estimatedRowHeight = 100.0
        tableVIew.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func updateUI() {
        navigationBarApeearence()
        startIndicatorAnimate()
        dismissesKeyboardByTouch()
        guard let userData = DataManager.shared.userDatail else { return }
        APIServices.instance.getMessage(member_id: userData.studentID ?? "", dialog_id: dialogId?.dialogID ?? "", page: 1) { (message) in
            DispatchQueue.main.async {
                self.message = message?.reversed()
                self.stopIndicatorAnimate()
                self.firstLabel.text = self.dialogId?.fullName ?? ""
                self.secondLabel.text = self.dialogId?.target ?? ""
                self.profileImageView.loadImageUsingCache(withUrl: self.dialogId?.avatar ?? "")
                self.tableVIew.reloadData()
                self.updateTableContentInset()
            }
        }
    }
    
    func updateTableContentInset() {
        let numRows = tableView(self.tableVIew, numberOfRowsInSection: 0)
        var contentInsetTop = self.tableVIew.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.tableVIew.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        self.tableVIew.contentInset = UIEdgeInsets(top: contentInsetTop, left: 0, bottom: 0, right: 0)
        guard self.message != nil else { return }
        let indexPath = NSIndexPath(item: (self.message?.count ?? 0) - 1, section: 0)
        tableVIew.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let user = DataManager.shared.userDatail else { return }
        guard let dialog = dialogId else { return }
        startIndicatorAnimate()
        APIServices.instance.CreateMessage(member_id: user.studentID, dialog_id: dialog.dialogID ?? "", target: dialog.target ?? "", message: messageTextField.text ?? "", media: image.jpegData(compressionQuality: 0.3)) { (message) in
            DispatchQueue.main.async {
                let mesage = Message.init(dialogID: dialog.dialogID, message: message?.message, memberID: message?.memberID, cdate: message?.cdate, seen: "0", typeMessage: nil, target: dialog.target, totalRow: self.message?.first?.totalRow ?? 0 + 1)
                if message?.result == "success" {
                    self.message?.append(mesage)
                } else {
                    
                    self.presentCDAlertWarningAlert(message: message?.message ?? "", completion: {
                        //
                    })
                }
                self.tableVIew.reloadData()
                self.updateTableContentInset()
                self.image = UIImage()
                self.messageTextField.text = ""
                self.stopIndicatorAnimate()
            }
        }
    }
    
    @IBAction func fileButtonPressed(_ sender: Any) {
        self.answserButton(title1: "انتخاب دوربین", title2: "انتخاب از گالری")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.image = image
            self.messageTextField.text = "media"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func answserButton(title1: String, title2: String) {
        let alert = CDAlertView(title: "توجه !", message: "لطفا تصویر خود را انتخاب کنید", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        alert.messageFont = UIFont(name: IRAN_SANS_MOBILE_FONT, size: 14)!
        let done1 = CDAlertViewAction(title: title2, font: UIFont(name: IRAN_SANS_MOBILE_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            return true
        }
        let done2 = CDAlertViewAction(title: title1, font: UIFont(name: IRAN_SANS_MOBILE_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            return true
        }
        let cancel = CDAlertViewAction(title: "هیچکدام", font: UIFont(name: IRAN_SANS_MOBILE_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: done1)
        alert.add(action: done2)
        alert.add(action: cancel)
        alert.show()
    }
    
}

extension MessageDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let incomingCell = tableView.dequeueReusableCell(withIdentifier: "inComingCell", for: indexPath) as! MessageDetailIncomingTableViewCell
        let outcomingCell = tableView.dequeueReusableCell(withIdentifier: "outComingCell", for: indexPath) as! MessageDetailOutComingTableViewCell
        guard let id = DataManager.shared.userDatail?.studentID else { return incomingCell }
        guard let messages = self.message else { return incomingCell }
        let message = messages[indexPath.row]
        if message.memberID == id {
            outcomingCell.dateLabel.text = message.cdate
            outcomingCell.messageLabel.text = message.message
            if message.seen == "1" {
                outcomingCell.seenImageView.image = #imageLiteral(resourceName: "ic_homweork_seen_32")
            } else {
                outcomingCell.seenImageView.image = #imageLiteral(resourceName: "ic_homweork_see_32")
            }
            if message.message?.contains("https://glsrap.com") ?? false {
                outcomingCell.dateLabel.text = ""
                outcomingCell.messageLabel.text = ""
                outcomingCell.backgroundImage.loadImageUsingCache(withUrl: message.message ?? "")
            }
            return outcomingCell
        } else {
            incomingCell.dateLabel.text = message.cdate
            incomingCell.messageLabel.text = message.message
            if message.message?.contains("https://glsrap.com") ?? false {
                incomingCell.dateLabel.text = ""
                incomingCell.messageLabel.text = ""
                incomingCell.backgroundImage.loadImageUsingCache(withUrl: message.message ?? "")
            }
            return incomingCell
        }
        
    }
    

    
    
    
}


extension UIViewController {
    
    func presentCDAlertWarningAlert(message: String, completion: @escaping () -> Void) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: IRAN_SANS_MOBILE_FONT, size: 15)!
        alert.messageFont = UIFont(name: IRAN_SANS_MOBILE_FONT, size: 13)!
        let done = CDAlertViewAction.init(title: "باشه", font: UIFont(name: IRAN_SANS_MOBILE_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (alert) -> Bool in
            completion()
            return true
        }
        alert.add(action: done)
        alert.show()
    }

}
