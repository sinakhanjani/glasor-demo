//
//  ViewController.swift
//  SearchExample
//
//  Created by Sinakhanjani on 2/6/1398 AP.
//  Copyright © 1398 iPersianDeveloper. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var filtered = [Contact]()
    var searchAvtivity: Bool = false
    var names: [Contact]?
    
    override func viewDidAppear(_ animated: Bool) {
        let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.textAlignment = .right
        searchTextField.attributedPlaceholder = NSAttributedString(string: "مخاطب خود را جستجو کنید", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarApeearence()
        searchBar.delegate = self
        updateUI()
    }
    
    func updateUI() {
        SearchBarAppearence()
        guard let user = DataManager.shared.userDatail else { return }
        APIServices.instance.getContanct(base_id: user.baseID, schoolId: user.schoolID) { (data) in
            DispatchQueue.main.async {
                self.names = data
                self.tableView.reloadData()
            }
        }
    }
    
    func SearchBarAppearence() {
        searchBar.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let names = names else { return }
        if !searchText.isEmpty {
            searchAvtivity = true
            self.filtered = names.filter({ (country) -> Bool in
                return country.fullName?.lowercased().contains(searchText.lowercased()) ?? false
            })
        } else {
            self.filtered = [Contact]()
            searchAvtivity = false
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MessageDetailViewController {
            if let dialog = sender as? Dialog {
                vc.dialogId = dialog
            }
            
        }
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchAvtivity {
            return filtered.count
        }
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        guard let names = names else { return cell }
        if searchAvtivity {
            let filter = filtered[indexPath.row]
            cell.configureCell(nameLabel: filter.fullName ?? "", className: filter.title ?? "")
            guard filter.avatar != "https://glsrap.com/api/uploads/" else { return cell }
            cell.iconImageView.loadImageUsingCache(withUrl: filter.avatar ?? "")
        } else {
            let name = names[indexPath.row]
            cell.configureCell(nameLabel: (name.fullName ?? "") + "-" + (name.title ?? ""), className: name.target ?? "")
            guard name.avatar != "https://glsrap.com/api/uploads/" else { return cell }
            cell.iconImageView.loadImageUsingCache(withUrl: name.avatar ?? "")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = DataManager.shared.userDatail else { return }
        if searchAvtivity {
            let data = filtered[indexPath.row]
            APIServices.instance.createDialog(send_target: "دانش آموز", target: data.target ?? "", u_to: data.id ?? "0", u_from: user.studentID , schoolId: user.schoolID) { (dialog) in
                DispatchQueue.main.async {
                    let dialogTemp = Dialog(dialogID: dialog?.code, uFrom: nil, counter: nil, fullName: data.fullName, avatar: data.avatar, target: data.target, totalRow: nil)
                    self.performSegue(withIdentifier: "contactToDetail", sender: dialogTemp)
                }
            }
        } else {
            guard let contact = names else { return }
            let data = contact[indexPath.row]
            APIServices.instance.createDialog(send_target: "دانش آموز", target: data.target ?? "", u_to: data.id ?? "0", u_from: user.studentID , schoolId: user.schoolID) { (dialog) in
                DispatchQueue.main.async {
                    let dialogTemp = Dialog(dialogID: dialog?.code, uFrom: nil, counter: nil, fullName: data.fullName, avatar: data.avatar, target: data.target, totalRow: nil)
                    self.performSegue(withIdentifier: "contactToDetail", sender: dialogTemp)
                }
            }
        }
        
        //
    }
    
    
    
}





struct GetContanct: Codable {
    let contact: [Contact]?
}

struct Contact: Codable {
    let id: String?
    let title: String?
    let avatar: String?
    let fullName: String?
    let slug, target: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, avatar
        case fullName = "full_name"
        case slug, target
    }
}

struct CreateDialog: Codable {
    let code, result, dialog, message: String?
}

struct GetDialog: Codable {
    let result: [Dialog]?
}

struct Dialog: Codable {
    let dialogID, uFrom, counter, fullName: String?
    let avatar: String?
    let target: String?
    let totalRow: Int?
    
    enum CodingKeys: String, CodingKey {
        case dialogID = "dialog_id"
        case uFrom = "u_from"
        case counter
        case fullName = "full_name"
        case avatar, target
        case totalRow = "total_row"
    }
}

struct GetMessage: Codable {
    let result: [Message]?
}

struct Message: Codable {
    let dialogID, message, memberID, cdate: String?
    let seen, typeMessage, target: String?
    let totalRow: Int?
    
    enum CodingKeys: String, CodingKey {
        case dialogID = "dialog_id"
        case message
        case memberID = "member_id"
        case cdate, seen
        case typeMessage = "type_message"
        case target
        case totalRow = "total_row"
    }
}

struct CreateMessageDone: Codable {
    let result, message, cdate, type: String?
    let memberID: String?
    
    enum CodingKeys: String, CodingKey {
        case result, message, cdate, type
        case memberID = "member_id"
    }
}
