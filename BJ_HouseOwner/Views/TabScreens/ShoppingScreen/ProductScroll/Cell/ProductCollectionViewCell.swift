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
    
    var plusButtonActionBlock: (()-> Void)? = nil
    var minusButtonActionBlock: (()-> Void)? = nil
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        showAdderHideButton()
        plusButtonActionBlock?()
    }
    func hideAdderShowButton(){
        button.isHidden = false
        plusMinusView.isHidden = true
        //quatityLabel.text = "0"
    }
    func showAdderHideButton(){
        button.isHidden = true
        plusMinusView.isHidden = false
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        minusButtonActionBlock?()
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        plusButtonActionBlock?()
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
        button.layer.cornerRadius = 0
        
        // shadow styling
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4

    }
}
