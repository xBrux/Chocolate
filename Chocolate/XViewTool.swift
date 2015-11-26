//
//  XViewTool.swift
//  Chocolate
//
//  Created by BRUX on 8/28/15.
//  Copyright (c) 2015 brux All rights reserved.
//

import UIKit

extension UIView {
    
    func drawLineAtStartPoint(startPoint:CGPoint, endPoint:CGPoint, color:UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: startPoint.x, y: startPoint.y))
        path.addLineToPoint(CGPoint(x: endPoint.x, y: endPoint.y))
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.lineWidth = 1
        layer.strokeColor = color.CGColor
        self.layer.addSublayer(layer)
        return layer
    }
}
