//
//  CartViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/10/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    var cart:[Product] = []
    
    @IBOutlet weak var niceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        niceButton.backgroundColor = .red
                self.cart = ShoppingViewController.finalizedCart
        for prod in cart {
            print("product: \(prod.name[0].value)")
            print("wanted amoutn: \(prod.wantedQuantity)")
            print(" - - - -")
        }
    }

}
