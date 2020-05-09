//
//  SettingsTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    
    @IBAction func switchPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
