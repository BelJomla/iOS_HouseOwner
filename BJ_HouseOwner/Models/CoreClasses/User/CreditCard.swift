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
    let isValid:Bool
    
    
    init() {
        self.holderName = ""
        self.expireDate = Date()
        self.cardNumber = ""
        self.cvv = ""
        self.isValid = false
    }
    
    init(_ holderName:String, _ expireDate:Date, _ cardNumber:String, _ cvv:String, _ isValid:Bool) {
        
        self.holderName = holderName
        self.expireDate = expireDate
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.isValid = isValid
    }
    
    func asDictionary() -> [String:Any]{
        let dict = ["holderName":holderName,
                    "expireDate":expireDate,
                    "cardNumber":cardNumber,
                    "cvv":cvv,
                    "isValid":isValid] as [String : Any]
        return dict
    }
    
    func toString(){
        print("- holderName: \(holderName)")
        print("- expireDate: \(expireDate)")
        print("- cardNumber: \(cardNumber)")
        print("- cvv: \(cvv)")
        print("- isValid: \(isValid)")
    }
}
