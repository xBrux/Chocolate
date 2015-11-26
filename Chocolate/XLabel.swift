//
//  XLabel.swift
//  Chocolate
//
//  Created by BRUX on 4/13/15.
//  Copyright (c) 2015 brux All rights reserved.
//

import UIKit

public enum XLabelVerticalAlignment {
    case Top,Center,Bottom
}

public class XLabel: UILabel {

    public var textVerticalAlignment:XLabelVerticalAlignment = XLabelVerticalAlignment.Center {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        switch textVerticalAlignment {
        case .Top :
            rect.origin.y = bounds.origin.y
        case .Bottom :
            rect.origin.y = bounds.origin.y + bounds.size.height - rect.size.height
        case .Center :
            rect.origin.y = bounds.origin.y + (bounds.size.height - rect.size.height) / 2
        }
        return rect
    }
    
    public override func drawTextInRect(rect: CGRect) {
        let rect = textRectForBounds(rect, limitedToNumberOfLines: numberOfLines)
        super.drawTextInRect(rect)
    }
}
