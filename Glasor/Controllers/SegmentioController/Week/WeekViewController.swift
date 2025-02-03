//
//  WeekendViewController.swift
//  TEST
//
//  Created by Sinakhanjani on 9/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import Segmentio

class WeekViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet fileprivate weak var segmentioView: Segmentio!
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var containerView: UIView!
    
    var segmentioStyle = SegmentioStyle.onlyLabel
    var selectedSegmentioIndex = 5
    var week = [WeekList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
         VCContent()
        navigationBarApeearence()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: RELOAD_START, object: nil)

    }
    
    @objc func reload() {
        VCContent()
    }

    // Method
    func updateUI() {
        scrollView.delegate = self
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle, content: segmentioContent()
        )
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex
        let scrollViewWidth = UIScreen.main.bounds.width
        let contentOffsetX = scrollViewWidth * CGFloat(selectedSegmentioIndex)
        self.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
    }
    
    func setSegment() {
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            let scrollViewWidth = self.scrollView.frame.width
            self.selectedSegmentioIndex = segmentIndex
            let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
            self.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
            // Segmentio value changed
        }
    }
    
    func segmentioContent() -> [SegmentioItem] {
        let segments = [
            SegmentioItem(title: "شنبه", image: nil),
            SegmentioItem(title: "یکشنبه", image: nil),
            SegmentioItem(title: "دوشنبه", image: nil),
            SegmentioItem(title: "سه شنبه", image: nil),
            SegmentioItem(title: "چهارشنبه", image: nil),
            SegmentioItem(title: "پنج شنبه", image: nil)
        ]
        
        return segments.reversed()
    }
    
    fileprivate func preparedViewControllers() -> [WeekContentViewController] {
        var contentViewControllers = [WeekContentViewController]()
       // week = week.reversed()
        for (i,_) in segmentioContent().enumerated() {
            let vc = WeekContentViewController.create()
            vc.sample = self.week[i]
            contentViewControllers.append(vc)
        }

        return contentViewControllers.reversed()
    }
    
    
    func VCContent() {
        startIndicatorAnimate()
        guard let studentDetail = DataManager.shared.userDatail else { return }
            APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .shanbe) { (status) in
                if status == .success {
                    guard let week = APIServices.instance.weekList else { return }
                    self.week.append(week)
                    APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .yekshanbe) { (status) in
                        if status == .success {
                            guard let week = APIServices.instance.weekList else { return }
                            self.week.append(week)
                            APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .doshanbe) { (status) in
                                if status == .success {
                                    guard let week = APIServices.instance.weekList else { return }
                                    self.week.append(week)
                                    APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .seshanbe) { (status) in
                                        if status == .success {
                                            guard let week = APIServices.instance.weekList else { return }
                                            self.week.append(week)
                                            APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .charshanbe) { (status) in
                                                if status == .success {
                                                    guard let week = APIServices.instance.weekList else { return }
                                                    self.week.append(week)
                                                    APIServices.instance.getWeek(schoolId: studentDetail.schoolID, baseId: studentDetail.baseID, weekName: .panjshanbe) { (status) in
                                                        if status == .success {
                                                            guard let week = APIServices.instance.weekList else { return }
                                                            self.week.append(week)
                                                            DispatchQueue.main.async {
                                                                self.updateUI()
                                                                self.configureSegmentio()
                                                                self.configureScrollView()
                                                                self.setSegment()
                                                                NotificationCenter.default.post(name: RELOAD_STOP, object: nil)
                                                                
                                                            }

                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func configureSegmentio() {
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
    }
    
    fileprivate lazy var viewControllers: [UIViewController] = {
        
        return self.preparedViewControllers()
    }()
    
    fileprivate func configureScrollView() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),height: containerView.frame.height)
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize)
            viewController.didMove(toParent: self)
        }
    }
    
    
}
