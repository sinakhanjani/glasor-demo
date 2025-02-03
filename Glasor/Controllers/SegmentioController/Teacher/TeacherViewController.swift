//
//  TeacherViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import Segmentio

class TeacherViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet fileprivate weak var segmentioView: Segmentio!
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var containerView: UIView!
    
    var segmentioStyle = SegmentioStyle.onlyLabel
    var selectedSegmentioIndex = 1
    var teacher: TeacherList?
    var deputy: DeputyList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        self.updateUI()
        self.configureSegmentio()
        self.configureScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            let scrollViewWidth = self.scrollView.frame.width
            let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
            self.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
            // Segmentio value changed
        }
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
    
    func segmentioContent() -> [SegmentioItem] {
        let segments = [
            SegmentioItem(title: "کادر آموزشی", image: nil),
            SegmentioItem(title: "کادر اجرایی", image: nil)
        ]
        
        return segments.reversed()
    }
    
    fileprivate func preparedTeacherViewControllers() -> TeacherContentViewController {
        let teacher = TeacherContentViewController.create()
        return teacher
    }
    
    fileprivate func preparedDeputyViewControllers() ->  DeputyContentViewController {
        let deputy = DeputyContentViewController.create()
        return deputy
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
        
        return [preparedDeputyViewControllers(),preparedTeacherViewControllers()]
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
