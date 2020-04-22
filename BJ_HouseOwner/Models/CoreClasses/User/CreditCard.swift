//
//  CreditCard.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class CreditCard: Object{
    
    dynamic var holderName:String = ""
    dynamic var expireDate:Date = Date()
    dynamic var cardNumber:String = ""
    dynamic var cvv:String = ""
    dynamic var isValid:Bool = false
    
    
    convenience init(_ ignore:String?) {
        self.init()
        
        self.holderName = ""
        self.expireDate = Date()
        self.cardNumber = ""
        self.cvv = ""
        self.isValid = false
    }
    
    convenience init(_ holderName:String, _ expireDate:Date, _ cardNumber:String, _ cvv:String, _ isValid:Bool) {
        self.init()
        
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
