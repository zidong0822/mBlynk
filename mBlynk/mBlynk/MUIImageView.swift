//
//  MUIImageView.swift
//  Microduino
//
//  Created by Jifu Zhang on 5/22/16.
//  Copyright © 2016 Microduino. All rights reserved.
//

import Foundation
import UIKit

class MUIImageView: UIView {
    var image:UIImage? = nil
    var moving:Bool? = false;
    var originalColor:UIColor? = nil
    var originalCenter:CGPoint? = nil
    var totalCount:Int? = 0
    var uiViews:[UIView] = []
    let buffer:CGFloat = 50
    var cell:CGFloat? = nil
    
    func isMoving() -> Bool {
        return moving!
    }
    
    func setTotalCount(count : Int, c : CGFloat, views : [UIView]) {
        totalCount = count
        uiViews = views
        cell = c
    }
    
    override func drawRect(rect: CGRect) {
        image!.drawInRect(rect)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        moving = false
        originalColor = self.backgroundColor
        originalCenter = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.backgroundColor = UIColor.redColor()
        moving = true
        
        let touch:UITouch = touches.first!
        let currentPoint = touch.locationInView(self.superview)
        let previousPoint = touch.previousLocationInView(self.superview)
        
        var center:CGPoint = self.center
        center.x += (currentPoint.x - previousPoint.x)
        center.y += (currentPoint.y - previousPoint.y)
        print("height : \(bounds.height), width : \(bounds.width)")
        self.center = center;
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
        self.backgroundColor = originalColor
        var xcount:Int = Int(center.x / (bounds.width/2))
   
        print(center.x,xcount)
        
        let xremainder = center.x % (bounds.width/2)
 
        
        if (xcount % 2 == 0) {
            xcount += 1
        }
        if xcount <= 0 {
            xcount = 1
        }
        let x = (CGFloat(xcount) * (bounds.width/2))
        print("xcount : \(xcount), yremainder : \(xremainder), x : \(x)")
        center.x = x
        
        var ycount:Int = Int(center.y / (bounds.height/2))
        if (ycount % 2 == 0) {
            ycount += 1
        }
        
        if ycount <= 1 {
            ycount = 3
        }
        if ycount > totalCount!*2 {
            ycount = totalCount!*2-1
        }
        
        let y = (CGFloat(ycount) * (bounds.height/2))
        center.y = y
        moving = false
        
        // Target area
        let t1 = y - bounds.height/2
        let b1 = y + bounds.height/2
        let l1 = x - bounds.width/2
        let r1 = x + bounds.width/2

        for v in uiViews {
            let top = v.center.y - v.bounds.height/2
            let bottom = v.center.y + v.bounds.height/2
            let left = v.center.x - v.bounds.width/2
            let right = v.center.x + v.bounds.width/2
    
            
            if (l1 >= right - buffer && r1 <= (self.superview?.bounds.width)! + buffer) {
                self.center = center
            } else if (t1 >= bottom - buffer && b1 <= (self.superview?.bounds.height)! + buffer) {
                self.center = center
            } else if (r1 <= left + buffer && l1 >= -buffer) {
                self.center = center
            } else if (b1 <= top + buffer && t1 >= -buffer) {
                self.center = center
            } else {
                print(v.tag)
                self.center = originalCenter!
            }
        }
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        moving = false
    }
    
   }