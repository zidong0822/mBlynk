//
//  MUIButton.swift
//  Microduino
//
//  Created by Jifu Zhang on 5/25/16.
//  Copyright © 2016 Microduino. All rights reserved.
//

import Foundation

import UIKit

@objc protocol MUIButtonDelegate:NSObjectProtocol{
    optional func didTouchMyButton(button:MUIButton)
    optional func didTouchUpInsideButton(button:MUIButton)
    optional func didTouchUpOutsideButton(button:MUIButton)
}

enum MyControlEvents{
    case TouchUpInside
    case TouchUpOutside
    case TouchDown
}

class MUIButton: UIView {
    
    @IBOutlet var Label: UILabel!
    @IBOutlet var Button: UIButton!
    @IBOutlet var SegmentControl: UISegmentedControl!
    
    //声明三个属性、添加一个addTarget方法，注意Target和delegate一样要用weak修饰
    weak var target:AnyObject?
    var action:Selector?
    var controlEvents:MyControlEvents?
    weak var delegate:MUIButtonDelegate!
    
    func addTarget(target:AnyObject!, action: Selector!, forMyControlEvents controlEvents: MyControlEvents! ){
        self.target = target
        self.action = action
        self.controlEvents = controlEvents
    }
    
    
    var text:NSString? = nil
    var font:UIFont? = nil
    var color:UIColor? = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        makeupUI()
    }
    
    
    func makeupUI() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        
        Button.layer.borderWidth = 1
        Button.layer.cornerRadius = 3
        Button.layer.borderColor = UIColor(red: 107/256, green: 167/256, blue: 249/256, alpha: 1).CGColor
        Button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        Button.addTarget(self, action: #selector(MUIButton.buttonSelected(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
   
        
        Button.layer.borderWidth = 1
        Button.layer.cornerRadius = 0
        Button.layer.borderColor = UIColor(red: 107/256, green: 167/256, blue: 249/256, alpha: 1).CGColor
        Button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        Button.addTarget(self, action: #selector(MUIButton.buttonSelected(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        
        
    }
    
    
    func buttonSelected(button: UIButton) {
        
        button.selected = !button.selected
        
        if button.selected == true {
            button.backgroundColor = UIColor(red: 107/256, green: 167/256, blue: 249/256, alpha: 1)
        } else {
            button.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    
    
}
