//
//  ContainerViewController.swift
//  iOS Swift 2.2 Side Menu Sample
//
//  Created by Maxim on 31.03.16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

enum PanelCurrentPosition {
    case SideMenuClosed
    case SideMenuOpen
}

class ContainerViewController: UIViewController, MainViewControllerDelegate,MenuViewControllerDelegate {
    
    var centerNavigationController: UINavigationController!
    var centralViewController: MainViewController!
    var currentMenuPosition: PanelCurrentPosition = .SideMenuClosed
    var sideMenuViewController: MenuViewController?
    
    var panelOffset: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralViewController = MainViewController()
        centralViewController.delegate = self
        
        centerNavigationController = UINavigationController(rootViewController: centralViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
       
        
    }
    
    //MARK: CentralViewControllerDelegate methods
    func openSideMenu() {
        let menuHidden = currentMenuPosition != .SideMenuOpen
        if menuHidden {
            addSideMenu()
        }
        moveSideMenu(menuHidden)
    }
    
    func openCentralViewController() {
        switch currentMenuPosition {
        case .SideMenuOpen:
            openSideMenu()
        default:
            break
        }
    }
    

    //MARK: SideMenu moving InOut
    func addSideMenu() {
        if sideMenuViewController == nil {
            
            let menuViewController = MenuViewController()
            menuViewController.delegate = self
            
            addChildSideMenuController(menuViewController)
        }
        
    }
    
    func addChildSideMenuController (sideMenuController: MenuViewController) {
        view.insertSubview(sideMenuController.view, atIndex: 0)
        addChildViewController(sideMenuController)
        sideMenuController.didMoveToParentViewController(self)
    }
    
    func moveSideMenu (shallMove: Bool) {
        if shallMove {
            currentMenuPosition = .SideMenuOpen
            animateCentralPanel(CGRectGetWidth(centerNavigationController.view.frame) - panelOffset)
            
        } else {
            animateCentralPanel(0) {
                finished in
                self.currentMenuPosition = .SideMenuClosed
                self.sideMenuViewController = nil
            }
        }
    }
    
    func closeSideMenu() {
        
        openSideMenu()
    }
    
    func animateCentralPanel(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {self.centerNavigationController.view.frame.origin.x = targetPosition}, completion: completion)
    }
}
