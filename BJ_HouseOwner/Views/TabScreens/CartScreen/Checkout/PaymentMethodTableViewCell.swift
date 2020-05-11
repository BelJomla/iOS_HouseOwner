//
//  PaymentMethodTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/11/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
