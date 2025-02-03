//
//  NewsDetailViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/21/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import ImageSlideshow

class NewsDetailViewController: UIViewController {
    
    
    @IBOutlet weak var NewsImageView: ImageSlideshow!
    @IBOutlet weak var newsHeaderLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsViewsCount: UILabel!
    var newsID = "0"
    
    @IBOutlet weak var newsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        startIndicatorAnimate()
    }
    
    func updateUI() {
        guard let studentDetail = DataManager.shared.userDatail else { return }
        APIServices.instance.getNewsDetail(page: "1", schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, newsId: newsID, studentId: studentDetail.studentID) { (status) in
            self.webServiceAlert(withType: status, escape: { (status) in
                if status == .success {
                    self.updateSlide()
                }
            })
            DispatchQueue.main.async {
                self.stopIndicatorAnimate()
            }
        }
    }
    
    func updateSlide() {
        guard let newsDetail = APIServices.instance.newsDetail else { return }
        self.newsHeaderLabel.text = newsDetail.news[0].title
        self.newsDateLabel.text = newsDetail.news[0].cdate
        self.newsViewsCount.text = newsDetail.news[0].visit
        self.newsLabel.text = newsDetail.news[0].text
        var imagesAlbum: [String] = []
        imagesAlbum.append(newsDetail.news[0].image)
        for images in newsDetail.album {
            guard let image = images["image"] else { return }
            imagesAlbum.append(image)
        }
        var inputSource: [AlamofireSource] = []
        for image in imagesAlbum {
            let alamofire = AlamofireSource.init(urlString: image)!
            inputSource.append(alamofire)
        }
        self.NewsImageView.setImageInputs(inputSource)
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
            if index == 4 { index = 0 }
            self.NewsImageView.setCurrentPage(index, animated: true)
            index += 1
        }
    }
}

