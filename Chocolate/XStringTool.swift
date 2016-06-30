//
//  XStringTool.swift
//  Chocolate
//
//  Created by BRUX on 4/15/15.
//  Copyright (c) 2015 brux All rights reserved.
//

import Foundation

public extension String {
    
    //MARK: - Calculating 
    public func sizeWithFont(font:UIFont?) -> CGSize {
        return sizeWithFont(font, maxWidth: CGFloat.max)
    }
    
    public func sizeWithFont(font:UIFont?, maxWidth:CGFloat) -> CGSize {
        let f = font ?? UILabel().font!
        let fontAttribute = [NSFontAttributeName : f]
        return (self as NSString).boundingRectWithSize(CGSize(width: maxWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: fontAttribute, context: nil).size
    }
    
    public func toButtonWithFont(font:UIFont?) -> UIButton {
        let button = UIButton()
        button.setTitle(self, forState: UIControlState.Normal)
        button.frame = CGRect(origin: CGPoint.zero, size: sizeWithFont(font))
        if font != nil {
            button.titleLabel?.font = font!
        }
        return button
    }
    
    public func toLabelWithFont(font:UIFont?, maxWidth:CGFloat) -> UILabel {
        let label = UILabel()
        if font != nil {
            label.font = font!
        }
        label.text = self
        label.frame = CGRect(origin: CGPoint.zero, size: sizeWithFont(font, maxWidth:maxWidth))
        return label
        
    }
    
    public func toLabelWithFont(font:UIFont?) -> UILabel {
        return toLabelWithFont(font, maxWidth: CGFloat.max)
    }
    
    public func toLabelWithFont(font:UIFont? , isVertical:Bool) -> UILabel {
        if !isVertical {
            return toLabelWithFont(font)
        }else {
            if self.isChineseAtIndex(0) {
                let length = (self as NSString).length
                let unitSize = (self as NSString).substringWithRange(NSMakeRange(0, 1)).sizeWithFont(font)
                
                let label = UILabel()
                if font != nil {
                    label.font = font!
                }
                label.text = self
                label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: unitSize.width, height: unitSize.height * CGFloat(length) + 1))
                label.numberOfLines = length
                return label
            }else {
                let label = self.toLabelWithFont(font)
                
                label.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: label.bounds.height, height: label.bounds.width))
                return label
            }
        }
    }
}

extension String {
    func isChineseAtIndex(index:Int) -> Bool {
        if index >= (self as NSString).length {
            return false
        }
        let range = NSMakeRange(index, 1)
        let subString:NSString = (self as NSString).substringWithRange(range)
        let cString = subString.UTF8String
        if strlen(cString) == 3 {
            return true
        }else {
            return false
        }
    }
    
    func splitChinese() -> [String] {
        let str = self as NSString
        var splitStrings = [String]()
        var starIndex = 0
        var length = 0
        var mark = self.isChineseAtIndex(0)
        
        (0...str.length).forEach {
            if self.isChineseAtIndex($0) == mark && $0 < str.length {
                length += 1
            } else {
                let range = NSMakeRange(starIndex, length)
                let subString = str.substringWithRange(range) as String
                splitStrings += [subString]
                starIndex = $0
                length = 1
                mark = !mark
            }
        }
        
        return splitStrings
    }
}