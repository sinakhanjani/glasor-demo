//
//  NewsTableViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/20/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class NewsTableViewController: UIViewController {
    
    var pageNumber = 1
    var newsList: NewsList?
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.startIndicatorAnimate()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        updateUI()
    }
    
    
    func updateUI() {
        navigationBarApeearence()
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getNewsList(page: "\(pageNumber)", schoolId: studentDetail.schoolID, baseId: studentDetail.baseID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.newsList = APIServices.instance.newsList
                    self.tableView.reloadData()
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
    

}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NEWS_CELL_ID, for: indexPath) as! NewsTableViewCell
        guard let news = newsList?.news else { return UITableViewCell.init(frame: CGRect.zero) }
        cell.newsImageView.loadImageUsingCache(withUrl: news[indexPath.row].image)
        cell.newsDateLabel.text = news[indexPath.row].cdate
        cell.newsViewCount.text = news[indexPath.row].visit
        cell.newsTitleLabel.text = news[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = newsList?.news else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let newsId = news[indexPath.row].id
        performSegue(withIdentifier: NEWS_TO_DETAIL, sender: newsId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? NewsDetailViewController {
            vc.newsID = sender as! String
        }
    }
    
    
}
