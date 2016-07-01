//
//  AppDelegate.swift
//  mBlynk
//
//  Created by harvey on 16/6/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        
        let rootViewController = ContainerViewController()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
   
    }

    func applicationDidEnterBackground(application: UIApplication) {
     
    }

    func applicationWillEnterForeground(application: UIApplication) {
      
    }

    func applicationDidBecomeActive(application: UIApplication) {
  
    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

