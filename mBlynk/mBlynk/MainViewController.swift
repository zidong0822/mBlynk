//
//  ViewController.swift
//  mBlynk
//
//  Created by harvey on 16/6/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit


protocol MainViewControllerDelegate {
    func openSideMenu()
    func openCentralViewController()
}



enum Status:Int {
    case Play = 0
    case Move
    case Edit
}

class MainViewController: UIViewController {

    var delegate: MainViewControllerDelegate?
    var uiImageView: MUIImageView! = nil
    var uiImageView1: MUIImageView! = nil
    var banana: UIImageView? = UIImageView()
    var mankey: UIImageView? = UIImageView()
    var deleteImageView: UIImageView! = nil
    var netTranslation : CGPoint! = CGPoint(x: 0, y: 0)//平移
    var currentView:UIView? = nil
    var cell: CGFloat? = nil
    var count: Int? = nil
    var weightTag:Int = 0
    var filteredSubviews = [UIView]()
    var currentStatus:Status? = Status.Edit
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        
        self.title = "mBlynk"
        self.navigationController?.navigationBar.barTintColor =
            UIColor.hex("#23CF8D")
     
        view.backgroundColor = UIColor.darkGrayColor();
        drawLineForView()
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didSelectMeunRow), name: "didSelectMeunRow", object: nil)

        let singleTap = UITapGestureRecognizer(target: self,action:#selector(handleSingleTap))
        singleTap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(singleTap)
        
//        
//        banana!.frame = CGRectMake(marginX,marginY, HORIZONTALCELL * 2, VERTICELCELL * 1)
//        banana!.backgroundColor = UIColor.purpleColor()
//        view!.addSubview(banana!)
//        banana!.tag = 11
//        banana!.userInteractionEnabled = true
//        
//        mankey!.frame = CGRectMake(marginX,marginY, HORIZONTALCELL * 2, VERTICELCELL * 1)
//        mankey!.backgroundColor = UIColor.purpleColor()
//        view!.addSubview(mankey!)
//        mankey!.tag = 12
//        mankey!.userInteractionEnabled = true
//        
//        
//        let filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
//        
//        print(filteredSubviews)
        
        
//
//        let recognizer = MoveGestureRecognizer(target: self, action:#selector(handleTap))
//        recognizer.uiViews = filteredSubviews.filter({$0.tag != banana!.tag})
//        print("------",recognizer.uiViews)
//        recognizer.cancelsTouchesInView = true
//        recognizer.delegate = self
//        recognizer.isEdit = true
//        banana!.addGestureRecognizer(recognizer)
//   
//        let recognizer1 = MoveGestureRecognizer(target: self, action:#selector(handleTap))
//        recognizer1.uiViews = filteredSubviews.filter({$0.tag != mankey!.tag})
//        print("--------------",recognizer.uiViews)
//        recognizer1.cancelsTouchesInView = true
//        recognizer1.delegate = self
//        recognizer1.isEdit = true
//        mankey!.addGestureRecognizer(recognizer1)
   
        

//         deleteImageView = UIImageView(frame: CGRectMake(cell!*CGFloat(0), cell!*CGFloat(10), cell!*6, cell!*1))
//         deleteImageView.backgroundColor = UIColor.blueColor()
//         deleteImageView.tag = 345
//         deleteImageView.hidden = true
//         deleteImageView.userInteractionEnabled = false
//         self.view.addSubview(deleteImageView)

    }

    
    func drawLineForView(){
    
    
        let mpath = UIBezierPath()
        
        for index in 0 ..< 9 {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: i * HORIZONTALCELL, y:0))
            mpath.addLineToPoint(CGPoint(x: i * HORIZONTALCELL, y:MAIN_SCREEN_HEIGHT))
            
        }
        
        for index in 0 ..< 10 {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: 0, y: i * VERTICELCELL))
            mpath.addLineToPoint(CGPoint(x:MAIN_SCREEN_WIDTH, y: i * VERTICELCELL))
            
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = mpath.CGPath
        shapeLayer.frame = CGRect(x:marginX, y:marginY, width:MAIN_SCREEN_WIDTH, height:MAIN_SCREEN_HEIGHT)
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.fillColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineDashPattern = [NSNumber.init(int: 6), NSNumber.init(int: 6)]
        view.layer.addSublayer(shapeLayer)
        
    }
    
    func didSelectMeunRow(noti:NSNotification){

        
        let index = noti.object as! Int
        
        switch index {
        case 0:
            
            let button = mButton(frame:CGRectMake(marginX,marginY, HORIZONTALCELL * 2, VERTICELCELL * 1))
            button.backgroundColor = UIColor.purpleColor()
            view!.addSubview(button)
            button.tag = weightTag+10
            weightTag = button.tag
            button.userInteractionEnabled = true
            filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
            let recognizer = MoveGestureRecognizer(target: self, action:#selector(handleTap))
            recognizer.cancelsTouchesInView = true
            recognizer.delegate = self    
            recognizer.isEdit = true
            button.addGestureRecognizer(recognizer)
      
        case 1:
           
            let button = mButton(frame:CGRectMake(marginX,marginY, HORIZONTALCELL * 2, VERTICELCELL * 1))
            button.backgroundColor = UIColor.purpleColor()
            view!.addSubview(button)
            button.tag = 12
            button.userInteractionEnabled = true
        
            filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
            let recognizer = MoveGestureRecognizer(target: self, action:#selector(handleTap))
            recognizer.cancelsTouchesInView = true
            recognizer.delegate = self
            recognizer.isEdit = true
            button.addGestureRecognizer(recognizer)
      
            
            
        default: break
            
        }
        
        
        
        
        
        

//        let target = getAvailiableRoom(CGPoint(x: 2, y: 1))
//        let obj = MUIImageView(frame: CGRectMake(cell!*target.x, cell!*target.y, cell!*2, cell!))
//        obj.tag = 21
//        obj.userInteractionEnabled = true
//        obj.setEditMode(true)
//        obj.image = UIImage(named: "banana");
//        view.addSubview(obj)
//        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapRecoginer(_:)))
//        tapGesture1.cancelsTouchesInView = true
//        obj.addGestureRecognizer(tapGesture1)
//        
//        obj.delegate = self
//        let filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
//        obj.setTotalCount(count!, c: cell!, views: filteredSubviews.filter({$0.tag != obj.tag}))


    }

    func getAvailiableRoom(cgPoint : CGPoint) -> CGPoint {
        if (currentStatus != Status.Move) {
            return cgPoint
        }

        let filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
        var target: CGPoint = cgPoint

        for y in 1 ..< Int(count!)+1 {for x in 0 ..< 6 {

            target = CGPoint(x:(CGFloat(x)*2 + cgPoint.x)/2, y:(CGFloat(y)*2 + cgPoint.y)/2)
            print("(\(x), \(y)) -> (\(target.x), \(target.y))")
            var viewCount = 0
            for view in filteredSubviews  {
                let centerY = (view.center.y)/cell!
                let centerX = (view.center.x)/cell!
                let distanceX = abs(centerX - target.x)
                let distanceY = abs(centerY - target.y)
                let width = (view.bounds.width/cell! + cgPoint.x)/2
                let height = (view.bounds.height/cell! + cgPoint.y)/2
                let targetX = CGFloat(x) + cgPoint.x
                let targetY = CGFloat(y) + cgPoint.y

                if ((distanceY >= height && targetY <= CGFloat(count!)) || (distanceX >= width && targetX <= 6)) {

                    viewCount += 1

                    if (viewCount == filteredSubviews.count) {

                        return CGPoint(x: CGFloat(x), y: CGFloat(y))
                    }
                }
            }
            }
        }

        return cgPoint
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

 // MARK: - UIGestureRecognizerDelegate

extension MainViewController:UIGestureRecognizerDelegate{


    func handleSingleTap(recognizer: UITapGestureRecognizer){
        
        if((recognizer.view?.isKindOfClass(UIView.classForCoder())) != nil){
            
            delegate?.openSideMenu()
        }
    }
    
    func tapRecoginer(gestureRecognizer: UIPanGestureRecognizer){
        
//        let bottom = ((gestureRecognizer.view?.center.y)! + (gestureRecognizer.view?.bounds.height)!/2)/cell!
//        
//        if(bottom>=10){
//            
//            deleteImageView.hidden = false
//            deleteImageView.backgroundColor = UIColor.redColor()
//            
//            if(gestureRecognizer.state == UIGestureRecognizerState.Ended){
//                
//                gestureRecognizer.view?.hidden = true
//                
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                    
//                    dispatch_async(dispatch_get_main_queue()) {
//                        gestureRecognizer.view?.removeFromSuperview()
//                        self.deleteImageView.hidden = true
//                        self.deleteImageView.backgroundColor = UIColor.blueColor()
//                    }
//                }}}else{
//            
//            self.deleteImageView.hidden = true
//            self.deleteImageView.backgroundColor = UIColor.blueColor()
//            
//        }
        
    }

    func handleTap(recognizer:UIGestureRecognizer) {
        
        
        
        print("handleTap")
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("gestureRecognizerShouldBegin")
        
        
        
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        print("gestureRecognizer")
        
        return true
    }
    

    
    

}



 // MARK: - MUIImageView  Delegate

extension MainViewController:MUIImageViewDelegate{

    
    
    func deleteNow(view : UIView){
        
        
    }
}


