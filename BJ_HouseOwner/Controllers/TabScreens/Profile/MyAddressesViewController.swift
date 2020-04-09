//
//  MyAddressesViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class MyAddressesViewController: UIViewController {
    @IBOutlet weak var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Addresses")
        
        styleUI()
    }
    
    func styleUI() {
           tableView.layer.cornerRadius = tableView.layer.frame.width/10
       }

}
