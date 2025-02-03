//
//  MessageViewController.swift
//  Master
//
//  Created by Teodik Abrami on 4/16/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    
    var dialog: [Dialog]?
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateUI() {
        navigationBarApeearence()
        startIndicatorAnimate()
        dismissesKeyboardByTouch()
        guard let userData = DataManager.shared.userDatail else { return }
        APIServices.instance.getDialog(student_id: userData.studentID , schoolId: userData.schoolID ?? "", page: 1) { (dialog) in
            DispatchQueue.main.async {
                self.dialog = dialog
                self.stopIndicatorAnimate()
                self.messageTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MessageDetailViewController {
            if let dialogId = sender as? Dialog {
                vc.dialogId = dialogId
            }
        }
    }

    @IBAction func barButtonPressed(_ sender: Any) {
       performSegue(withIdentifier: "listToContact", sender: nil)
    }
}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialog?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MssageListTableViewCell
        guard let dialog = dialog else { return cell }
        let owner = dialog[indexPath.row]
        cell.firstLabel.text = owner.fullName
        cell.secondLabel.text = owner.target
        guard owner.avatar != "https://glsrap.com/api/uploads/" else { return cell }
        cell.imageView2.loadImageUsingCache(withUrl: owner.avatar ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dialog = dialog else { return }
        let dialogi = dialog[indexPath.row]
        performSegue(withIdentifier: "dialogToDetail", sender: dialogi)
    }
    
    
}
