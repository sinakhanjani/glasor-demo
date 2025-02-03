//
//  GradientView.swift
//  FerFere
//
//  Created by Teodik Abrami on 10/28/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//


import UIKit


@IBDesignable
class GradientView1: UIImageView {
    
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        print("1")
        let gradientLayer = CAGradientLayer()
        let middleColor = bottomColor.withAlphaComponent(0)
        gradientLayer.colors = [topColor.cgColor,middleColor.cgColor,thirdColor.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

@IBDesignable
class GradientView2: UIImageView {
    
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        print("1")
        let gradientLayer = CAGradientLayer()
        let middleColor = bottomColor.withAlphaComponent(1)
        gradientLayer.colors = [topColor.cgColor,middleColor.cgColor,thirdColor.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

@IBDesignable
class GradientView3: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        print("1")
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor,thirdColor.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}



