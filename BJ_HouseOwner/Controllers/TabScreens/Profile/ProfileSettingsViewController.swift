//
//  ProfileSettingsViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    let settingsNames = ["Allow GPS Access",
    "Allow Delivery Guy Calls",
    "Automatic Purchases", "Prevent Background Activities"]
    
    let sectionNames = ["Privacy", "Delivery", "General"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("profile Settings")
        styleUI()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: K.UITableCells.nibNames.profileSettings, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: K.UITableCells.IDs.profileSettings)
        
        
    }
    
    func styleUI() {
        let topInset = 30
        tableView.contentInset.top = CGFloat(topInset)
        
//        tableView.layer.cornerRadius = tableView.layer.frame.width/10
    }
    


}


//MARK: -TableView

extension ProfileSettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        3
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let myCell = cell as! SettingsTableViewCell
        myCell.label.text = settingsNames[indexPath.row]
        
        if Int.random(in: 0...1) == 0 {
            myCell.settingsSwitch.isOn = false
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: K.UITableCells.IDs.profileSettings, for: indexPath)
        
    }
    
}
