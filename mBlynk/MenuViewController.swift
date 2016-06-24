//
//  MenuViewController.swift
//  mBlynk
//
//  Created by harvey on 16/6/22.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
protocol  MenuViewControllerDelegate {
    func closeSideMenu()

}
class MenuViewController: UIViewController {

    
    var delegate: MenuViewControllerDelegate?
    override func viewDidLoad() {
        
        let menuTableview = UITableView(frame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT), style:UITableViewStyle.Plain)
        menuTableview.backgroundColor = UIColor(rgba:"#E6E6E6")
        menuTableview.dataSource = self
        menuTableview.delegate = self
        menuTableview.tableFooterView = UIView()
        self.view.addSubview(menuTableview)
        
    }
    

    
    
}
extension MenuViewController:UITableViewDelegate,UITableViewDataSource{

    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let tableCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        tableCell.selectionStyle = UITableViewCellSelectionStyle.None
        return tableCell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
   
    
        NSNotificationCenter.defaultCenter().postNotificationName("didSelectMeunRow", object:indexPath.row);
       delegate?.closeSideMenu()
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }

}

