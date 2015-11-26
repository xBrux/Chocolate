//
//  XCATool.swift
//  Chocolate
//
//  Created by BRUX on 3/19/15.
//  Copyright (c) 2015 brux All rights reserved.
//
import UIKit

extension CALayer {
    
    public func snap() -> UIImage {
        let frame = self.frame
        self.frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.frame = frame
        return image
    }
    
    public enum SplitWay {
        case Vertical
        case Horizontal
    }
    
    /**
    将Layer按照marks的标记切成若干张UIImage
    
    - parameter way:      切割标记的走向，与切割方向垂直
    - parameter marks:    切割标记，必须从小到大排列，最后一个值必须小鱼等于fullSize的宽或者高（取决于切割方向），最后一个值以后的部分将被忽略
    - parameter fullSize: 切割之前的尺寸
    
    - returns: 切割好的UIImage
    */
    public func snapAndSplit(way:SplitWay, marks:[CGFloat]) -> [UIImage] {
        let snapImage = self.snap()
        var lastMark:CGFloat = 0
        
        return marks.reduce([UIImage]()) { (totol , mark) -> [UIImage] in
            switch way {
            case .Horizontal:
                return [UIImage]()
                //TODO: - Finish it
            case .Vertical:
                // Create rectangle from middle of current image
                let croprect = CGRect(x: 0, y: lastMark * UIScreen.mainScreen().scale, width: self.bounds.width * UIScreen.mainScreen().scale, height: (mark - lastMark) * UIScreen.mainScreen().scale)
                
                lastMark = mark
                // Draw new image in current graphics context
                if let imageRef = CGImageCreateWithImageInRect(snapImage.CGImage, croprect) {
                    
                    // Create new cropped UIImage
                    let croppedImage = UIImage(CGImage: imageRef)
                    
                    return totol + [croppedImage]
                } else {
                    return totol + [UIImage()]
                }
            }
        }
    
    }
}
