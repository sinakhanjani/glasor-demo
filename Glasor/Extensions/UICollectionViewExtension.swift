//
//  UICollectionViewExtension.swift
//  Glasor
//
//  Created by Sinakhanjani on 2/3/1398 AP.
//  Copyright © 1398 Teodik Abrami. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func drawLineFrom(from: IndexPath,to: IndexPath, lineWidth: CGFloat = 2,strokeColor: UIColor = UIColor.blue) {
        guard let fromCell = cellForItem(at: from) as? CollectionViewCell else { return }
        guard let toCell = cellForItem(at: to) as? CollectionViewCell else { return }
        let defualtPoint = CGPoint(x: 6.0, y: 6.0)
        let fromPoint = fromCell.circleView.convert(defualtPoint, to: self)
        let toPoint = toCell.circleView.convert(defualtPoint, to: self)
        print(fromPoint,toPoint)
        let path = UIBezierPath()
        path.move(to: convert(fromPoint, to: self))
        path.addLine(to: convert(toPoint, to: self))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(layer)
        
    }
    
    
}
