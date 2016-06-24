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

class MainViewController: UIViewController,UIGestureRecognizerDelegate,MUIImageViewDelegate {

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
    var currentStatus:Status? = Status.Edit

    enum Status:Int {
        case Play = 0
        case Move
        case Edit
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "mBlynk"
        self.view.tag = 1000

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didSelectMeunRow), name: "didSelectMeunRow", object: nil)

        let singleTap = UITapGestureRecognizer(target: self,action:#selector(handleSingleTap))
        singleTap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(singleTap)
        
        view.backgroundColor = UIColor.darkGrayColor();
        cell = self.view.bounds.size.width / 6
        count = Int(self.view.bounds.size.height / cell!)
        let mpath = UIBezierPath()
        for index in 0 ..< (Int(count!)+1) {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: 0, y: i * cell!))
            mpath.addLineToPoint(CGPoint(x: self.view.bounds.size.width, y: i * cell!))
            
        }

        for index in 1 ..< 6 {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: i * cell!, y: 0))
            mpath.addLineToPoint(CGPoint(x: i * cell!, y:self.view.bounds.size.height))
           
        }

        // CGShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = mpath.CGPath
        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        shapeLayer.strokeColor = UIColor.greenColor().CGColor
        shapeLayer.fillColor = UIColor.greenColor().CGColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineDashPattern = [NSNumber.init(int: 6), NSNumber.init(int: 6)]
        view.layer.addSublayer(shapeLayer)
        
        
         banana!.frame = CGRectMake(cell!, cell!, cell! * 1, cell! * 2)
         banana!.backgroundColor = UIColor.purpleColor()
         view.addSubview(banana!)
         banana!.tag = 11
         banana?.userInteractionEnabled = true
        
        
        let filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
        
         let recognizer = MoveGestureRecognizer(target: self, action:#selector(handleTap))
         recognizer.setTotalCount(count!, c: cell!, views: filteredSubviews.filter({$0.tag != banana!.tag}))
         recognizer.cancelsTouchesInView = true
         recognizer.delegate = self
         recognizer.isEdit = true
        
         banana!.addGestureRecognizer(recognizer)
         let tapRecoginer1 = UIPanGestureRecognizer(target: self,action:#selector(tapRecoginer))
        tapRecoginer1.cancelsTouchesInView = true
         banana?.addGestureRecognizer(tapRecoginer1)
        let tapGestureb = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureb.numberOfTapsRequired = 1
        banana!.addGestureRecognizer(tapGestureb)

         deleteImageView = UIImageView(frame: CGRectMake(cell!*CGFloat(0), cell!*CGFloat(10), cell!*6, cell!*1))
         deleteImageView.backgroundColor = UIColor.blueColor()
         deleteImageView.tag = 345
         deleteImageView.hidden = true
         deleteImageView.userInteractionEnabled = false
         self.view.addSubview(deleteImageView)

    }

    func handleSingleTap(recognizer: UITapGestureRecognizer){

        if((recognizer.view?.isKindOfClass(UIView.classForCoder())) != nil){
            
                delegate?.openSideMenu()
        }
    }
  
    func tapRecoginer(gestureRecognizer: UIPanGestureRecognizer){

        let bottom = ((gestureRecognizer.view?.center.y)! + (gestureRecognizer.view?.bounds.height)!/2)/cell!
        
        if(bottom>=10){
          
            deleteImageView.hidden = false
            deleteImageView.backgroundColor = UIColor.redColor()
            
            if(gestureRecognizer.state == UIGestureRecognizerState.Ended){
            
                gestureRecognizer.view?.hidden = true
             
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                 
                    dispatch_async(dispatch_get_main_queue()) {
                        gestureRecognizer.view?.removeFromSuperview()
                        self.deleteImageView.hidden = true
                        self.deleteImageView.backgroundColor = UIColor.blueColor()
                    }
                }}}else{
        
            self.deleteImageView.hidden = true
            self.deleteImageView.backgroundColor = UIColor.blueColor()
        
        }
        
    }

    func didSelectMeunRow(noti:NSNotification){


        let target = getAvailiableRoom(CGPoint(x: 2, y: 1))
        let obj = MUIImageView(frame: CGRectMake(cell!*target.x, cell!*target.y, cell!*2, cell!))
        obj.tag = 21
        obj.userInteractionEnabled = true
        obj.setEditMode(true)
        obj.image = UIImage(named: "banana");
        view.addSubview(obj)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapRecoginer(_:)))
        tapGesture1.cancelsTouchesInView = true
        obj.addGestureRecognizer(tapGesture1)
        
        obj.delegate = self
        let filteredSubviews = self.view.subviews.filter({$0.tag > 0 && $0.hidden == false})
        obj.setTotalCount(count!, c: cell!, views: filteredSubviews.filter({$0.tag != obj.tag}))


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



    func handleTap(recognizer: UITapGestureRecognizer) {

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



    func deleteNow(view : UIView){


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

