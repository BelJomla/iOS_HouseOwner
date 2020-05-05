//
//  MyAddressesTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/5/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class MyAddressesTableViewCell: UITableViewCell {
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var holderNameLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
    }
    
    func styleUI(){
        cardView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignCardNumber(number:String){
        var styledNumber = ""
        
        for i in 0..<number.count{
            if i%4 == 0 && i != 0{
                styledNumber.append("  ")
            }
            
            styledNumber.append(String(Array(number)[i]))
            print(styledNumber)

        }
        self.cardNumberLabel.text = styledNumber
    }
    
    func assignExpiryDate(date:Date){
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        var twoDigitsMonth = ""
        
        if month<10{
            twoDigitsMonth = "0\(month)"
        }else{
            twoDigitsMonth = "\(month)"
        }
        
        let index = 2 // 1987 -> 87
        let twoYearDigits = String(year).substring(from: index)
        
        self.expiryDateLabel.text = "\(twoYearDigits)/\(twoDigitsMonth)"
    }
    
}
