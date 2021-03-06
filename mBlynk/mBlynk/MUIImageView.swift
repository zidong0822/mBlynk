//
//  MUIImageView.swift
//  Microduino
//
//  Created by Jifu Zhang on 5/22/16.
//  Copyright © 2016 Microduino. All rights reserved.
//

import Foundation
import UIKit

protocol MUIImageViewDelegate {
    func deleteNow(view : UIView)
}

class MUIImageView: UIView {
    var image:UIImage? = nil
    var moving:Bool? = false;
    var originalColor:UIColor? = nil
    var originalCenter:CGPoint? = nil
    var totalCount:Int? = 0
    var uiViews:[UIView] = []
    let buffer:CGFloat = 50
    var cell:CGFloat? = nil
    var isEdit:Bool? = false
    var delegate : MUIImageViewDelegate?
    
    func isMoving() -> Bool {
        return moving!
    }
    
    func setTotalCount(count : Int, c : CGFloat, views : [UIView]) {
    
        totalCount = count
        uiViews = views
        cell = c
    }
    
    
    func setEditMode(edit : Bool) {
        isEdit = edit
    }
    
    override func drawRect(rect: CGRect) {
        image!.drawInRect(rect)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (isEdit! == false) {
            moving = false
            return
        }
        
        moving = false
        originalColor = self.backgroundColor
        originalCenter = self.center
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
 
        if (isEdit! == false) {
            moving = false
            return
        }
        
        self.backgroundColor = originalColor
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
        moving = false
        
        if (yy/cell! >= 9) {
            delegate?.deleteNow(self)
        }
        
        // Target area
        let t1 = yy - bounds.height/2
        let b1 = yy + bounds.height/2
        let l1 = xx - bounds.width/2
        let r1 = xx + bounds.width/2
        //        print("t1 : \(t1), b1 : \(b1), l1 : \(l1), r1 : \(r1)")
        for v in uiViews {
            let top = v.center.y - v.bounds.height/2
            let bottom = v.center.y + v.bounds.height/2
            let left = v.center.x - v.bounds.width/2
            let right = v.center.x + v.bounds.width/2
            //            print("to : \(top), bo : \(bottom), le : \(left), ri : \(right)")
            
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
        isEdit = false
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (isEdit! == false) {
            moving = false
            return
        }
        
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
}