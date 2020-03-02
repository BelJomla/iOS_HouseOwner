//
//  shoppingCollectionCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/22/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class shoppingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        // dividing the width by 2 gives us a circular view
        let cellCornerRadius = self.layer.frame.size.width/2
        let mainViewCornerRadius = mainView.layer.frame.size.width/2
        // updating corners to make them circular
        self.layer.cornerRadius = cellCornerRadius
        mainView.layer.cornerRadius = mainViewCornerRadius
        
        // shadow styling
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        
    }

}
