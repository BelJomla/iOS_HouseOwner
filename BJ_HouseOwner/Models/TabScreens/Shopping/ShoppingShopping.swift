//
//  Shopping.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/15/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//


import Foundation
import UIKit
import CoreGraphics

class ShoppingStyling {
    
    init() {
        //
        print("intialized styling")
    }
    
    func styleNavigationBar( _ navigationItem:UINavigationItem,_ tabBarController: UITabBarController?,_ navigationController: UINavigationController?){
        
        // changes the title of the nav bar
        navigationItem.title = "Shopping"
        // chages the background color to non transparent
        navigationController?.navigationBar.isTranslucent = false
        /*
         The following line hides the navigation bar propapigated from the tabBarController. If it was isHidden is assinged to false, it will appear again, but it will not look good.
         */
        tabBarController?.navigationController?.navigationBar.isHidden = true
        
        
        // adding the search components
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor(rgb: Colors.darkBlue)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // adding cart button
        let cartButton = UIButton(type: .system)
        cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        cartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        
        navigationItem.rightBarButtonItem?.action = #selector(buttonClicked)
        
        //background
        //        navigationController?.navigationBar.tintColor = UIColor(rgb: Colors.darkBlue)
        //        navigationController?.navigationBar.backgroundColor = UIColor(rgb: Colors.darkBlue)
        //navigationController?.navigationBar.isHidden = true
    }
    @objc func buttonClicked() {
        print("button has been clicked")
    }
    
    func styleTableView (tableView:UITableView) {
        tableView.layer.cornerRadius = 50
        
        tableView.contentInset  = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0  )
       
        tableView.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
    }
}
