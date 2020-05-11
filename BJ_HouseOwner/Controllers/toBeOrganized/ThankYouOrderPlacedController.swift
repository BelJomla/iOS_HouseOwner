//
//  ThankYouOrderPlacedController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/17/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit


class ThankYouOrderPlacedController: UIViewController{
    

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonPressed(_ sender: UIButton) {
       
       ShoppingViewController.finalizedCart = []
        self.navigationController?.popToRootViewController(animated: true)
        
        CartViewController.forwardToOrders = true
    }
    
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = UIColor(rgb: Colors.darkBlue)
        
        mainView.backgroundColor = UIColor(rgb: Colors.darkBlue)
        
        image.layer.cornerRadius = 20
        button.layer.cornerRadius = 20
    }
    
    
}
