//
//  MyCardsViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class MyCardsViewController: UIViewController {
    

 // only one user would be there
    
    var currentUser:User? = nil
    var creditCards:[CreditCard] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("my cards")
        
        setUpTableView()
        styleUI()
        prepareUIDataFromDB()

    }
    func prepareUIDataFromDB(){
        let readData = RealmManager.shared.read(User.self)
        self.currentUser = readData[readData.count-1]
        
        for card in currentUser!.creditCards{
            let readCard = CreditCard(card.holderName, card.expireDate, card.cardNumber, card.cvv, card.isValid)
            
            creditCards.append(readCard)
        }
        
    }
    func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: K.UITableCells.nibNames.creditCardCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.UITableCells.IDs.creditCardCell)
    }
    
    func styleUI() {
           tableView.layer.cornerRadius = tableView.layer.frame.width/10
        tableView.contentInset.top = 25
        
        var image = UIImage(systemName: "plus.rectangle")
        image?.withTintColor(.white)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "Add Card",
        style: .plain,
        target: self,
        action: #selector(addCardPressed))
        
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addCardPressed))
       }
   
    @objc func addCardPressed(){
        performSegue(withIdentifier: K.segues.profile.toAddCreditCard, sender: self)
    }
    
}


//MARK: -UITableView

extension MyCardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        creditCards.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let myCell = cell as! MyAddressesTableViewCell
        
        myCell.assignCardNumber(number: creditCards[indexPath.row].cardNumber)
        myCell.assignExpiryDate(date: creditCards[indexPath.row].expireDate)
        myCell.holderNameLabel.text = creditCards[indexPath.row].holderName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: K.UITableCells.IDs.creditCardCell)!
    }
    
    
}

