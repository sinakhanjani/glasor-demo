//
//  ExamAndResultViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/27/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import Segmentio

class ExamAndResultViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet fileprivate weak var segmentioView: Segmentio!
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var containerView: UIView!
    
    var segmentioStyle = SegmentioStyle.onlyLabel
    var selectedSegmentioIndex = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatorAnimate()
    }
    
    override func viewWillLayoutSubviews() {
        self.updateUI()
        self.configureSegmentio()
        self.configureScrollView()
        updateSegmeten()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func updateSegmeten() {
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            let scrollViewWidth = self.scrollView.frame.width
            let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
            self.selectedSegmentioIndex = segmentIndex
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
            SegmentioItem(title: "آزمون ها", image: nil),
            SegmentioItem(title: "نتایج", image: nil)
        ]
        return segments.reversed()
    }
    
    fileprivate func preparedExamViewControllers() -> ExamContentViewController {
        let exam = ExamContentViewController.create()
        return exam
    }
    
    fileprivate func preparedResultViewControllers() ->  ResultContentViewController {
        let result = ResultContentViewController.create()
        return result
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
        
        return [preparedResultViewControllers(),preparedExamViewControllers()]
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
