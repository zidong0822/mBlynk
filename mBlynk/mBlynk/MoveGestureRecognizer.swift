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
        var realCenter:CGPoint? = nil
        var totalCount:Int? = 0
        var xCount:Int? = 0
        var yCount:Int? = 0
        var uiViews:[UIView] = []
        let buffer:CGFloat = 44
        let hBuffer:CGFloat = MAIN_SCREEN_WIDTH/8
        let vBuffer:CGFloat = MAIN_SCREEN_HEIGHT/9
        var cell:CGFloat? = nil
        var isEdit:Bool? = false
        var overbool:Bool = false
        var uiImageView: UIView! = nil
        
        override init(target: AnyObject?, action: Selector) {
            super.init(target: target, action: action)
       
        }
        
        func isMoving() -> Bool {
            return moving!
        }
        
        func setEditMode(edit : Bool) {
            isEdit = edit
        }
    
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
          
            self.view?.superview?.bringSubviewToFront(self.view!)
            
            if (isEdit! == false) {
                moving = false
                return
            }
            
            moving = false
            originalColor = self.view?.backgroundColor
            originalCenter = self.view?.center
        }
        
        override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            
            if (isEdit! == false) {
                moving = false
                return
            }
            self.view?.backgroundColor = originalColor
            let bounds = self.view!.bounds
            var reallyCenter = CGPointMake(self.view!.center.x-10,self.view!.center.y-74)
            let xx = CGFloat(xCount!)*HORIZONTALCELL+(bounds.width/2)
            reallyCenter.x = xx+10
            let yy = CGFloat(yCount!)*VERTICELCELL+(bounds.height/2)
            reallyCenter.y = yy+74
            self.view!.center = reallyCenter

       
        }
        
        
 
        
        override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
   
            moving = false
            isEdit = false
            
            print("touchesCancelled")
            
        }
        
        
        
        
        
        override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
     
            self.view?.backgroundColor = UIColor.greenColor()
            
            if (isEdit! == false) {
                moving = false
                return
            }
            
            moving = true
            var center = self.view!.center
   
            let touch:UITouch = touches.first!
            
            let currentPoint = touch.locationInView(self.view)
 
            let previousPoint = touch.previousLocationInView(self.view)

            center.x += (currentPoint.x - previousPoint.x)

            center.y += (currentPoint.y - previousPoint.y)

            self.view!.center = center
            let bounds = self.view!.bounds
            let realCenter = CGPointMake(self.view!.center.x-10,self.view!.center.y-74)
            
            
            uiViews =  (self.view?.superview?.subviews.filter({$0.tag != self.view!.tag}))!
            
            
            if(uiViews.count==0){
            
                 xCount = Int((realCenter.x - (bounds.width/2))/HORIZONTALCELL)
                 yCount = Int((realCenter.y - (bounds.height/2))/VERTICELCELL)
            }
            
            for v in uiViews {
            
              
               if   CGRectContainsPoint(v.frame,(self.view?.center)!) && CGRectIntersectsRect(v.frame,(self.view?.frame)!){
    
               }else{
                
                xCount = Int((realCenter.x - (bounds.width/2))/HORIZONTALCELL)
                yCount = Int((realCenter.y - (bounds.height/2))/VERTICELCELL)
                
                }
            }
            if !overbool{
            
                moving = false
                
                
                
                if xCount <= 0 {
                    xCount = 0
                }
                if Int(8 - xCount!) <= Int(bounds.width/HORIZONTALCELL){
                    
                    xCount = 8 - Int(bounds.width/HORIZONTALCELL)
                    
                }
             
                
                if(yCount<=0){
                    
                    yCount = 0
                }
                if Int(11 - yCount!) <= Int(bounds.height/VERTICELCELL){
                    
                    yCount = 11 - Int(bounds.height/VERTICELCELL)
                }
                print(xCount,yCount)
              
            }else{
                moving = false
           
            }
            overbool = false
            
        }
        
    }
