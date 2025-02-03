//
//  UIViewExtension.swift
//  FerFere
//
//  Created by Teodik Abrami on 10/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY + 100
            
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
}

extension UIView {
    func shadowView() {
//        let shadowPath = UIBezierPath()
//        shadowPath.move(to: CGPoint(x: self.bounds.origin.x, y: self.frame.size.height))
//        shadowPath.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height + 7.0))
//        shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
//        shadowPath.close()
//        
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOpacity = 0.7
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = shadowPath.cgPath
//        self.layer.shadowRadius = 5
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}



