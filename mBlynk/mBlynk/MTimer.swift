//
//  MTimer.swift
//  Microduino
//
//  Created by Jifu Zhang on 5/25/16.
//  Copyright © 2016 Microduino. All rights reserved.
//

import Foundation

import UIKit

class MTimer: UIView {
    var image:UIImage? = nil
    
    override func drawRect(rect: CGRect) {
        image!.drawInRect(rect)
    }
}