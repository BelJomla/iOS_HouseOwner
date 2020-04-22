//
//  User.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class User: Object{
    dynamic var ID:String = ""
    dynamic var firstName:String = ""
    dynamic var lastName:String = ""
    dynamic var mobileNumber:String = ""
    dynamic var balance:Double = 0.0
    dynamic var points:Int = 0
    dynamic var type:Int = 0
//    dynamic var locations = List<UserLocation> //:[UserLocation] = [UserLocation()]
//    dynamic var creditCards = List<CreditCard> //:[CreditCard] = [CreditCard()]
    let locations = List<UserLocation>()
    let creditCards = List<CreditCard>()
    
    convenience init(_ ID:String,_ firstName:String,_ lastName:String,_ mobileNumber:String,_ balance:Double,_ points:Int,_ type:Int,_ locations:[UserLocation],_ creditCards: [CreditCard]) {
        self.init()
        
        self.ID = ID
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.balance = balance
        self.points = points
        self.type = type
        
        for location in locations{
            self.locations.append(location)
        }
        for creditCard in creditCards {
            self.creditCards.append(creditCard)
        }
        
//        self.locations = locations
//        self.creditCards = creditCards
    }
    
    convenience init(_ ignore:String?) {
        self.init()
        
        self.ID = ""
        self.firstName = ""
        self.lastName = ""
        self.mobileNumber = ""
        self.balance = 0.0
        self.points = 0
        self.type = 0
        
        self.locations.append(UserLocation())
        self.creditCards.append(CreditCard())
        
    }
    
    
    func toString(){
        print("ID: \(ID)")
        print("firstName: \(firstName)")
        print("lastName: \(lastName)")
        print("mobileNumber \(mobileNumber)")
        print("balance \(balance)")
        print("points \(points)")
        print("type \(type)")
        
        for location in locations {
            print("A location: ")
            location.toString()
        }
        
        for card in creditCards {
            print("A Card: ")
            card.toString()
        }
        
        
    }
}
