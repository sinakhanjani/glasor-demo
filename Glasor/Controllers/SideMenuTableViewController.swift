//
//  SideMenuTableViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import SideMenuController

let CHAT_SGUE = "7"

class SideMenuTableViewController: UITableViewController {
    
    private var previousIndex = 0
    
    let segues = [LOADER_TO_MAIN_SEGUE, MAIN_TO_WEEK, MAIN_TO_EXAM, SIDE_NEWS_SEGUE, MAIN_TO_HOMEWORK_SEGUE, MAIN_TO_DAILY ,"assesment" , SIDE_SCHOOL_PROFILE , CHAT_SGUE,MAIN_TO_RESET_PASS,""]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNumberLabel: UILabel!
    @IBOutlet weak var profileImageView: RoundedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userInfo = DataManager.shared.userDatail else { return }
        nameLabel.text = userInfo.fName + " " + userInfo.lName
        classNumberLabel.text = userInfo.classTitle
        profileImageView.loadImageUsingCache(withUrl: userInfo.logo)
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == previousIndex {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            if indexPath.row == 10 {
                Authentication.auth.authenticationUser(isLoggedIn: false, userInfo: nil)
                dismiss(animated: true, completion: nil)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
                let selected = indexPath.row
               // guard selected != 0 else { return }
                self.sideMenuController?.performSegue(withIdentifier: self.segues[selected], sender: nil)
                self.previousIndex = indexPath.row
            }
         
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
}
