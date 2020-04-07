//
//  User.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


class User {
    var ID:String
    var firstName:String
    var lastName:String
    var mobileNumber:String
    var balance:Double
    var points:Int
    var type:Int
    var locations:[UserLocation] = [UserLocation()]
    var creditCards:[CreditCard] = [CreditCard()]
    
    init(_ ID:String,_ firstName:String,_ lastName:String,_ mobileNumber:String,_ balance:Double,_ points:Int,_ type:Int,_ locations:[UserLocation],_ creditCards: [CreditCard]) {
        
        self.ID = ID
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.balance = balance
        self.points = points
        self.type = type
        self.locations = locations
        self.creditCards = creditCards
    }
    
    init() {
        self.ID = ""
        self.firstName = ""
        self.lastName = ""
        self.mobileNumber = ""
        self.balance = 0.0
        self.points = 0
        self.type = 0
        self.locations = [UserLocation()]
        self.creditCards = [CreditCard()]
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
