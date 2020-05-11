//
//  CartViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/10/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit
import SDWebImage


class CartViewController: UIViewController {

    var cart:[Product] = []
    static var forwardToOrders = false
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    var tatalPriceValue = 0.0
    let prefferedLang = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        prepareTableView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.cart = ShoppingViewController.finalizedCart
        updateTotalPrice()
        tableView.reloadData()
        
        if CartViewController.forwardToOrders{
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            
                CartViewController.forwardToOrders = false
            self.tabBarController?.selectedIndex = 1
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ShoppingViewController.finalizedCart = self.cart
    }

    func styleUI(){
        finishButton.layer.cornerRadius = 10
    }

    func prepareTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: K.UITableCells.nibNames.cartCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.UITableCells.IDs.cartCell)
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        
        if self.cart.isEmpty {
            okAlert("Items Required", "You seem to have forgotten to add items to your cart"){
            }
            
        }else{
            performSegue(withIdentifier: K.segues.cartScreen.toCheckout, sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.segues.cartScreen.toCheckout){
                let viewController = segue.destination as? CheckoutViewController
            viewController?.priceValue = totalPrice.text!
            viewController?.cart = self.cart
        }
    }
}


extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.UITableCells.IDs.cartCell) as! CartTableViewCell
        
        
        var productInCart = getProductWithId(cart, cart[indexPath.item])
        if let product = productInCart {
            
            cell.minusButtonActionBlock = {
                if product.wantedQuantity > 0 { // this line might not be needed
                    product.wantedQuantity -= 1
                    cell.wantedQuantity.text = String(product.wantedQuantity)
                }
                self.updateTotalPrice()
                tableView.reloadData()
            }
            cell.plusButtonActionBlock = {
                product.wantedQuantity += 1
                cell.wantedQuantity.text = String(product.wantedQuantity)
                
                self.updateTotalPrice()
                tableView.reloadData()
            }
            
            
            var name:String = ""
            for i in 0..<product.name.count{
                if product.name[i].key == prefferedLang {
                    name = product.name[i].value
                }
            }
            
            cell.titleLabel.text = name
            cell.priceLabel.text = String(product.sellingPrice)
            let url = URL(string: product.imageURLs[0])
            cell.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
            cell.wantedQuantity.text = String(product.wantedQuantity)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.cart[indexPath.item].wantedQuantity = 0
            self.cart.remove(at: indexPath.item)
            print("cart size: \(cart.count)")
            updateTotalPrice()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            ShoppingViewController.finalizedCart = self.cart
        }
    }
}

//MARK: -Class Helpers
extension CartViewController{
    func stylePrice(_ totalPrice:Double) -> String{
        var price = String(totalPrice)
        var styledPrice = ""
        for i in 0..<price.count{
            if i%3 == 0 {
                styledPrice.append(",")
            }
            styledPrice.append(price[i])
        }
        price = "SR \(price)"
        
        return price
    }
}


extension CartViewController {

    
    func productInCart(_ products:[Product],_ product:Product) -> Bool {
        for prod in products {
            if prod.ID == product.ID{
                return true
            }
        }
        return false
    }
    
    func getProductWithId (_ products:[Product],_ product:Product) -> Product? {
        if productInCart(products, product){
            for prod in products {
                if prod.ID == product.ID{
                    return prod
                }
            }
        }
        return nil
    }
}

//MARK: -Class helpers

extension CartViewController {
    
func updateTotalPrice(){
    let price = computeTotalProice(self.cart)
    self.tatalPriceValue = price
    self.totalPrice.text = self.stylePrice(price)
    
}

func computeTotalProice(_ products:[Product]) -> Double{
    var total = 0.0
    for product in products {
        total += Double(product.wantedQuantity) * product.sellingPrice
    }
    return total
}
}
