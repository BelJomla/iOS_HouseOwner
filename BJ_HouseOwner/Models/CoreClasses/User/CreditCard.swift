//
//  CreditCard.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class CreditCard{
    let holderName:String
    let expireDate:Date
    let cardNumber:String
    let cvv:String
    
    
    init() {
        self.holderName = ""
        self.expireDate = Date()
        self.cardNumber = ""
        self.cvv = ""
    }
    
    init(_ holderName:String, _ expireDate:Date, _ cardNumber:String, _ cvv:String) {
        
        self.holderName = holderName
        self.expireDate = expireDate
        self.cardNumber = cardNumber
        self.cvv = cvv
    }
    
    func asDictionary() -> [String:Any]{
        let dict = ["holderName":holderName,
                    "expireDate":expireDate,
                    "cardNumber":cardNumber,
                    "cvv":cvv] as [String : Any]
        return dict
    }
    
    func toString(){
        print("- holderName: \(holderName)")
        print("- expireDate: \(expireDate)")
        print("- cardNumber: \(cardNumber)")
        print("- cvv: \(cvv)")
    }
}
