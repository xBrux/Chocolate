//
//  XColorTool.swift
//  Chocolate
//
//  Created by BRUX on 7/2/15.
//  Copyright (c) 2015 brux All rights reserved.
//

import UIKit

public extension UIColor {
    
    /**
    从十六进制的颜色代码获取UIColor对象(⚠️前面不加#)；支持RGB，ARGB，RRGGBB，AARRGGBB
    
    - parameter code: 十六进制的颜色代码
    
    - returns: 对应的UIColor对象
    */
    public class func colorWithHexCode(code : String) -> UIColor {
        
        if let color = rgbaFromHexCode(code) {
            return UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        }else {
            return UIColor.clearColor()
        }
        
    }
    
    private class func rgbaFromHexCode(hexCode:String) -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)? {
        let colorComponent = {(startIndex : Int ,length : Int) -> CGFloat in
            var subHex = hexCode.substringWithRange(Range<String.Index>(start: hexCode.startIndex.advancedBy(startIndex), end: hexCode.startIndex.advancedBy(startIndex + length)))
            subHex = subHex.characters.count < 2 ? "\(subHex)\(subHex)" : subHex
            var component:UInt32 = 0
            NSScanner(string: subHex).scanHexInt(&component)
            return CGFloat(component) / 255.0}
        
        switch(hexCode.characters.count) {
        case 3: //#RGB
            let red = colorComponent(0,1)
            let green = colorComponent(1,1)
            let blue = colorComponent(2,1)
            return (red,green,blue,1.0)
        case 4: //#ARGB
            let alpha = colorComponent(0,1)
            let red = colorComponent(1,1)
            let green = colorComponent(2,1)
            let blue = colorComponent(3,1)
            return (red,green,blue,alpha)
        case 6: //#RRGGBB
            let red = colorComponent(0,2)
            let green = colorComponent(2,2)
            let blue = colorComponent(4,2)
            return (red,green,blue,1.0)
        case 8: //#AARRGGBB
            let alpha = colorComponent(0,2)
            let red = colorComponent(2,2)
            let green = colorComponent(4,2)
            let blue = colorComponent(6,2)
            return (red,green,blue,alpha)
        default:
            return nil
        }
    }
    
    /**
    从十六进制的颜色代码初始化UIColor对象(⚠️前面不加#)；支持RGB，ARGB，RRGGBB，AARRGGBB
    
    - parameter hexCode: 十六进制的颜色代码
    
    */
    public convenience init(hexCode:String) {
        if let color = UIColor.rgbaFromHexCode(hexCode) {
            self.init(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        }else {
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0)
        }
    }
}

