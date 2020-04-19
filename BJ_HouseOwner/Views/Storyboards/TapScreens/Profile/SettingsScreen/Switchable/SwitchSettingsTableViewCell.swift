//
//  SwitchSettingsTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/19/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class SwitchSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var theSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
