//
//  CheckoutViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/11/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var changeLocationButton: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var paymentTableView: UITableView!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var containerViewGrey: UIView!
    let onlyAllowedIndex = 0
    var priceValue = ""
    
    var paymentMethods = [PaymentMethod("Cash On Delivery", true), PaymentMethod("My Wallet", false), PaymentMethod("Credit Card", false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalPrice.text = priceValue
        
        paymentTableView.dataSource = self
        paymentTableView.delegate = self
        let nib = UINib(nibName: K.UITableCells.nibNames.checkoutPaymentMethod, bundle: nil)
        paymentTableView.register(nib, forCellReuseIdentifier: K.UITableCells.IDs.checkoutPaymentMethod)
        styleUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.totalPrice.text = priceValue
    }
    func styleUI(){
        addressView.layer.cornerRadius = 10
        paymentTableView.layer.cornerRadius = 10
        checkoutButton.layer.cornerRadius = 10
        containerViewGrey.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        
    }
    @IBAction func checkoutPressed(_ sender: UIButton) {
    }
}

struct PaymentMethod{
    var name:String
    var isChecked:Bool
    init(_ name:String, _ isChecked:Bool) {
        self.name = name
        self.isChecked = isChecked
    }
    mutating func setIsChecked(isChecked:Bool){
        self.isChecked = isChecked
    }
}


//MARK: -UITableView
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.UITableCells.IDs.checkoutPaymentMethod) as! PaymentMethodTableViewCell
        Logger.log(.success, "did run 23")
        cell.label.text = paymentMethods[indexPath.row].name
        cell.icon.isHidden = !paymentMethods[indexPath.row].isChecked

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<paymentMethods.count{
            paymentMethods[i] = PaymentMethod(paymentMethods[i].name, false)
        }
        paymentMethods[indexPath.row] = PaymentMethod(paymentMethods[indexPath.row].name, true)
        if indexPath.row != onlyAllowedIndex {
            okAlert("Not Currently Supported", "We are only accepting cash on delivery method, stay tooned for the next update where we enable the rest"){


                let defaultIndexPath = IndexPath(row: 0, section: 0)
                tableView.selectRow(at: defaultIndexPath, animated: true, scrollPosition: .none)
                tableView.delegate?.tableView!(tableView, didSelectRowAt: defaultIndexPath)
            }
        }
        tableView.reloadData()
    }
}
