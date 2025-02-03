//
//  ChartCollectionView.swift
//  Glasor
//
//  Created by Sinakhanjani on 2/3/1398 AP.
//  Copyright © 1398 Teodik Abrami. All rights reserved.
//

import UIKit

class ChartCollectionView: NSObject,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var inputs = [(x: Double, y: Double, xName: String, yName: String)]() //[(x: 0.0, y: 0.0, xName: "Ax", yName: ""), (x: 0.0, y: 16.0, xName: "Bx", yName: "By"), (x: 0.0, y: 12.0, xName: "Cx", yName: "Cy"), (x: 0.0, y: 20.0, xName: "Dx", yName: "Dy")]
    var rotate = true
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"chartCell", for: indexPath) as! CollectionViewCell
        let maxCellHeight = cell.frame.height - cell.circleView.frame.height
        let points = drawChart(inputs, maxCellHeight: maxCellHeight, maxChartY: 20.0)
        let point = points[indexPath.row]
        let input = inputs[indexPath.item]
        cell.heightConstraint.constant = point
        if rotate {
            cell.xNameLabel.transform = CGAffineTransform(rotationAngle: -45)
        }
        cell.xNameLabel.text = input.xName
        cell.numberLabel.text = "\(input.y)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row > 0 {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
//                collectionView.drawLineFrom(from: IndexPath.init(row: indexPath.row - 1, section: 0), to: indexPath, lineWidth: 1.0, strokeColor: .black)
//            }
//        }
    }
    
    func drawChart(_ data: [(x: Double, y: Double, xName: String, yName: String)], maxCellHeight: CGFloat, maxChartY y: Double) -> [CGFloat] {
        var heights = [CGFloat]()
        let points = data.map { $0.y }
        let maxHeight = Double(maxCellHeight) - Double(21 + 23)
        let efficiency = maxHeight / y
        guard efficiency > 0 else { return [CGFloat]() }
        for point in points {
            let height = CGFloat(efficiency * point)
            heights.append(height)
        }
        return heights
    }
    
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer)
    }
    
    
}
