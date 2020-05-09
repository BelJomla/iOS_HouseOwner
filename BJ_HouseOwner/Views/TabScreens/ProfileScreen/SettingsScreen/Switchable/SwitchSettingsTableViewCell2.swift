//
//  SwitchSettingsTableViewCell2.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/8/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class SwitchSettingsTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var theSwitch: UISwitch!
    var actionBlock: (() -> Void)? = nil
    

    @IBAction func switchPressed(_ sender: UISwitch) {
        print("the swithc is pressed")
        actionBlock?()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
