//
//  CartTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/10/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var adderView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wantedQuantity: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    
    var plusButtonActionBlock: (()-> Void)? = nil
    var minusButtonActionBlock: (()-> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
        // Initialization code
    }
    func styleUI(){
        adderView.layer.cornerRadius = 10
        minusButton.layer.cornerRadius = 10
        plusButton.layer.cornerRadius = 10
        
    }
    @IBAction func minusPressed(_ sender: Any) {
        minusButtonActionBlock?()
    }
    @IBAction func plusPressed(_ sender: Any) {
        plusButtonActionBlock?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
