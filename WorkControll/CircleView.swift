//
//  CircleView.swift
//  WorkControll
//
//  Created by Андрей Илалов on 20.11.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    var path: UIBezierPath?
    var shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        layer.addSublayer(shapeLayer)
    }
    
    func drawAPercentCircle(percent: Double) {
        let center = CGPoint(x: frame.width/2, y: frame.height/2)
        let radius = frame.width/2

        path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(2*Double.pi*percent - 0.5*Double.pi), clockwise: true)
        
        shapeLayer.path = path?.cgPath
        let newColor = UIColor(red: 154.0/255, green: 194.0/255, blue: 197.0/255, alpha: 1.0)
        shapeLayer.strokeColor = newColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
    }
}
