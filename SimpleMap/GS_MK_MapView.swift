//
//  GS_MK_MapView.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/14/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import UIKit

class GS_MK_MapView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let mycontext = UIGraphicsGetCurrentContext();
        CGContextSetFillColor(mycontext, [1,0,0,1]);
        CGContextFillRect(mycontext, CGRect(origin: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y), size: CGSize(width: self.frame.size.width, height: self.frame.size.height)))
        
        /*CGContextBeginPath(mycontext)
        CGContextMoveToPoint(mycontext, self.frame.height, self.frame.width)
        CGContextSetLineWidth(mycontext, 50.0)
        CGContextSetLineJoin(mycontext, kCGLineJoinRound)
        CGContextSetLineCap(mycontext, kCGLineCapRound)
        CGContextAddEllipseInRect(mycontext, CGRect(origin: CGPoint(x: 250.0, y: 250.0), size: CGSize(width: 100.0, height: 100.0)))
        CGContextSetStrokeColor(mycontext, [0,0,0,1])
        CGContextStrokePath(mycontext)*/
        
    }
    

}
