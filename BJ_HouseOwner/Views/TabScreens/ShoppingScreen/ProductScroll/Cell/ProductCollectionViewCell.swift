//
//  ProductCollectionViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/5/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var quatityLabel: UILabel!
    @IBOutlet weak var plusMinusView: UIView!

    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBAction func addToCartPressed(_ sender: UIButton) {
        
        button.isHidden = true
        plusMinusView.isHidden = false
        quatityLabel.text = "1"
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        var currentQuatity = Int(quatityLabel.text!)
        if(currentQuatity! != 0){
            currentQuatity! -= 1
        }
        
        quatityLabel.text = String(currentQuatity!)
        
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        var currentQuatity = Int(quatityLabel.text!)
        
        currentQuatity! += 1
        
        quatityLabel.text = String(currentQuatity!)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        plusMinusView.backgroundColor = UIColor(rgb: Colors.darkBlue)
        plusButton.layer.cornerRadius = plusButton.frame.width/2
        minusButton.layer.cornerRadius = plusButton.frame.width/2
        outerView.layer.cornerRadius = 10
        
        let borderColor : UIColor = UIColor(rgb: Colors.darkBlue)
        button.backgroundColor =  UIColor(rgb: Colors.darkBlue)
        cartView.layer.masksToBounds = true
        cartView.layer.borderColor = borderColor.cgColor
        cartView.layer.borderWidth = 1.0
        cartView.layer.cornerRadius = 5
        
        //
        button.layer.cornerRadius = 5
        
        // shadow styling
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
        
        
    }
    
}
