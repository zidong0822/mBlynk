//
//  ViewController.swift
//  mBlynk
//
//  Created by harvey on 16/6/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    var uiImageView: MUIImageView! = nil
    var uiImageView1: MUIImageView! = nil
    var banana: UIImageView? = UIImageView()
    var mankey: UIImageView? = UIImageView()
    var netTranslation : CGPoint! = CGPoint(x: 0, y: 0)//平移
    var currentView:UIView? = nil
    var cell: CGFloat? = nil
    var count: Int? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGrayColor();
        cell = self.view.bounds.size.width / 6
        count = Int(self.view.bounds.size.height / cell!)
        let mpath = UIBezierPath()
        for index in 0 ..< (Int(count!)+1) {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: 0, y: i * cell!))
            // 绘到 （290， 120）这个点
            mpath.addLineToPoint(CGPoint(x: self.view.bounds.size.width, y: i * cell!))
            print("index: \(index), i: \(i), cell : \(i * cell!)")
        }
        
        for index in 1 ..< 6 {
            let i = CGFloat(index);
            mpath.moveToPoint(CGPoint(x: i * cell!, y: 0))
            // 绘到 （290， 120）这个点
            mpath.addLineToPoint(CGPoint(x: i * cell!, y:self.view.bounds.size.height))
            print("index: \(index), i: \(i), cell : \(i * cell!)")
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
        banana?.userInteractionEnabled = true
        self.view.addSubview(banana!)
        banana!.tag = 11
        
        mankey!.frame = CGRectMake(cell!*2, cell!*3, cell! * 2, cell! * 2)
        mankey!.backgroundColor = UIColor.purpleColor()
        mankey?.userInteractionEnabled = true
        self.view.addSubview(mankey!)
        mankey!.tag = 12
        
        let filteredSubviews = self.view.subviews.filter({$0.tag > 0})
        for view in filteredSubviews  {
            print(view.tag)
        }
        
        
        
        let recognizer = MoveGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        recognizer.setTotalCount(count!, c: cell!, views: filteredSubviews.filter({$0.tag != banana!.tag}))
        recognizer.delegate = self
        banana!.addGestureRecognizer(recognizer)
        
        
        
        let recognizer1 = MoveGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        recognizer1.setTotalCount(count!, c: cell!, views: filteredSubviews.filter({$0.tag != mankey!.tag}))
        recognizer1.delegate = self
        mankey!.addGestureRecognizer(recognizer1)
        
        
        
    }

    func handleTap(recognizer: UITapGestureRecognizer) {
     
        
        print("handleTap")
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("gestureRecognizerShouldBegin")
        //        print("gestureRecognizerShouldBegin :\(gestureRecognizer.state.rawValue)")
        //        currentCenter = monkey.center
        return true
    }
    
    //    var currentCenter:CGPoint? = nil
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        print("gestureRecognizer")
        
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

