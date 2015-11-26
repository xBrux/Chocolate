//
//  XRectTool.swift
//  Chocolate
//
//  Created by BRUX on 1/12/15.
//  Copyright (c) 2015 Oracleen. All rights reserved.
//

import UIKit

public extension CGRect {
    public static func frameLeftNextTo(rect : CGRect, withSize size : CGSize, margin:CGFloat) -> CGRect {
        return CGRect(x: rect.origin.x + rect.width + margin, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    public static func frameRightNextTo(rect : CGRect, withSize size : CGSize, margin:CGFloat) -> CGRect {
        return CGRect(x: rect.origin.x - margin - size.width, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    public static func frameRightCenterIn(rect : CGRect, withSize size : CGSize) -> CGRect {
        return CGRect(x: rect.width - size.width, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    public static func frameLeftCenterIn(rect : CGRect, withSize size : CGSize) -> CGRect {
        return CGRect(x: 0, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    public static func frameCenterIn(rect : CGRect, withSize size : CGSize) -> CGRect {
        return CGRect(x: (rect.width - size.width) / 2 + rect.origin.x, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    public static func frameCenterIn(rect : CGRect, withWidth width : CGFloat) -> CGRect {
        return CGRect.frameCenterIn(rect, withSize: CGSize(width: width, height: width))
    }
    
    public func originByCenterIn(rect:CGRect) -> CGPoint {
        return CGPoint(x: (rect.width - self.width) / 2, y: (rect.height - self.height) / 2)
    }
    
    public func frameByCenterIn(rect:CGRect) -> CGRect {
        return CGRect(origin: originByCenterIn(rect), size: self.size)
    }
    
    public var bottomY:CGFloat {
        get {
            return self.origin.y + self.height
        }
    }
    
    public var rightX:CGFloat {
        get {
            return self.origin.x + self.width
        }
    }
}