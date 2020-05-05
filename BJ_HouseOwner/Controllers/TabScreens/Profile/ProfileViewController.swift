//
//  ProfileViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/2/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var bottomLargeView: UIView!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var settingsIcon: UIImageView!
    
    
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var pointsValueLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        populateUIWithDB()
        addTapGestures()
    }
    
    func populateUIWithDB(){
        let readData = RealmManager.shared.read(User.self)
        let currentUser = readData[readData.count-1] // only one user would be there
        
        balanceValueLabel.text = "SR \(currentUser.balance)"
        pointsValueLabel.text = "\(currentUser.points)"
        fullNameLabel.text = "\(currentUser.firstName) \(currentUser.lastName)"
        phoneNumberLabel.text = "\(currentUser.mobileNumber)"
    }
    
    func addTapGestures(){
        // Do any additional setup after loading the view.
        AddressView.addTapGesture(tapNumber: 1, target: self, action: #selector(addressViewClicked))
        historyView.addTapGesture(tapNumber: 1, target: self, action: #selector(historyViewClicked))
        cardView.addTapGesture(tapNumber: 1, target: self, action: #selector(cardViewClicked))
        settingsIcon.addTapGesture(tapNumber: 1, target: self, action: #selector(imageIconClicked))
    }
    
    @objc func addressViewClicked(){
        Logger.log(.success, "address clicked")
        performSegue(withIdentifier: K.segues.profile.toAddresses, sender: self)
    }
    @objc func historyViewClicked(){
        Logger.log(.success,"history clicked")
        performSegue(withIdentifier: K.segues.profile.toOrderHistory, sender: self)
    }
    @objc func cardViewClicked(){
        Logger.log(.success,"card clicked")
        performSegue(withIdentifier: K.segues.profile.toCards, sender: self)
    }
    @objc func imageIconClicked(){
        Logger.log(.success,"Image Icon clicked")
        performSegue(withIdentifier: K.segues.profile.toSettings, sender: self)
    }
    
    func styleUI(){
        balanceView.layer.cornerRadius = balanceView.layer.frame.width/2
        pointsView.layer.cornerRadius = pointsView.layer.frame.width/2
        bottomLargeView.layer.cornerRadius = 45
        bottomLargeView.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        AddressView.layer.cornerRadius = 10
        historyView.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10

    }
}

extension UIView {
  func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
    let tap = UITapGestureRecognizer(target: target, action: action)
    tap.numberOfTapsRequired = tapNumber
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }
}
