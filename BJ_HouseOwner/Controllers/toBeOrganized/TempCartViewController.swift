//
//  TempCartViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/7/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class TempCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        
            var tempProduct:Product? = nil
        
             DB.getProducts(withSubCollectionID: "4_3"){
                    products in
                    

                    RealmManager.shared.create(products[1])
                    tempProduct = products[1]
                    
                    let readData = RealmManager.shared.read(Product.self)
                    let products = [tempProduct!]
        
                    let currentUserArr = RealmManager.shared.read(User.self)
                    let userIndex = currentUserArr.count-1
                    let currentUser = currentUserArr[userIndex]
        
                    let order = Order(products, "currentUser.ID", "", .new)
        
                    DB.writeUserOrder(withUserOrder: "", order: order)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
