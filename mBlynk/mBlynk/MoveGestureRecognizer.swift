//
//  MoveGestureRecognizer.swift
//  Microduino
//
//  Created by Geeph Zhang on 6/1/16.
//  Copyright © 2016 Microduino. All rights reserved.
//

import Foundation

@objc public protocol MoveGestureDelegate {
    optional func isMoving()
}

class MoveGestureRecognizer:UIGestureRecognizer {
    var moving:Bool? = false;
    var originalColor:UIColor? = nil
    var originalCenter:CGPoint? = nil
    //    var cancel:Bool? = false
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        moving = false
        self.view?.superview?.bringSubviewToFront(self.view!)
     
        originalColor = self.view?.backgroundColor
        originalCenter = self.view?.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        self.view?.backgroundColor = UIColor.redColor()
        moving = true
        //中点位置
        var center = self.view!.center
        let touch:UITouch = touches.first!
        //当前位置
        let currentPoint = touch.locationInView(self.view)
        //前一个位置
        let previousPoint = touch.previousLocationInView(self.view)

        center.x += (currentPoint.x - previousPoint.x)
        center.y += (currentPoint.y - previousPoint.y)

        self.view!.center = center;
        
    }

    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded")
        self.view?.backgroundColor = originalColor
        var center = self.view!.center
        let bounds = self.view!.bounds
        
        var xxcount:Int = Int((center.x - (bounds.width/2))/cell!)
    
        
        if xxcount <= 0 {
            xxcount = 0
        }
        
        if Int(6 - xxcount) < Int(bounds.width/cell!){
            
            xxcount = 6 - Int(bounds.width/cell!)
            
        }
        
        let xx = CGFloat(xxcount)*cell!+(bounds.width/2)
        
         center.x = xx
        
        
        var yycount:Int = Int((center.y - (bounds.height/2))/cell!)
        
        if(yycount<=0){
            
            yycount = 0
            
        }
        
        if Int(11 - yycount) < Int(bounds.height/cell!){
            
            yycount = 11 - Int(bounds.height/cell!)
            
        }
        
        let yy = CGFloat(yycount)*cell!+(bounds.height/2)
        
        
        center.y = yy


        let t1 = yy - bounds.height/2
        let b1 = yy + bounds.height/2
        let l1 = xx - bounds.width/2
        let r1 = xx + bounds.width/2

        for v in uiViews {
            let top = v.center.y - v.bounds.height/2
            let bottom = v.center.y + v.bounds.height/2
            let left = v.center.x - v.bounds.width/2
            let right = v.center.x + v.bounds.width/2
        
            
            if (l1 >= right - buffer && r1 <= (self.view?.superview?.bounds.width)! + buffer) {
   
            } else if (t1 >= bottom - buffer && b1 <= (self.view?.superview?.bounds.height)! + buffer) {
   
                
            } else if (r1 <= left + buffer && l1 >= -buffer) {
   
            } else if (b1 <= top + buffer && t1 >= -buffer) {
 
            } else {
                print(v.tag)
                moving = false
                self.view!.center = originalCenter!
                return
            }
        }
        moving = false
        self.view!.center = center
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("touchesCancelled")
        moving = false
    }
    
    
}
