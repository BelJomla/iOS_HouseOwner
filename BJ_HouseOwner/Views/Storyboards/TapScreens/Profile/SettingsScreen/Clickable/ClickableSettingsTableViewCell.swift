//
//  ClickableSettingsTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/19/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class ClickableSettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
