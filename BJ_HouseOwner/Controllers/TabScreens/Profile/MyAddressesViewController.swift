//
//  MyAddressesViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class MyAddressesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Addresses")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        styleUI()
    }
    
    func styleUI() {
           tableView.layer.cornerRadius = tableView.layer.frame.width/10
       }

}


//MARK: -UITableView

extension MyAddressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: K.UITableCells.IDs.creditCardCell, for: indexPath)
    }
    
    
}
