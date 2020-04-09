//
//  MyCardsViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class MyCardsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("my cards")
        styleUI()
    }
    
    func styleUI() {
           tableView.layer.cornerRadius = tableView.layer.frame.width/10
       }


}
