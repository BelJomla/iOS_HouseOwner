//
//  User.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


class User {
    var ID:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var mobileNumber:String = ""
    var balance:Double = 0.0
    var points:Int = 0
    var type:Int = 0
    var locations:[UserLocation] = []
    var creditCards:[CreditCard] = []
    
    init(withID id: String) {

        UserDB.fetchUserDocument(withID: id) { (data) in
            
            if let data = data{

                self.ID = data[K.db.UserFeilds.ID["name"] as! String] as! String
                self.firstName = data[K.db.UserFeilds.firstName["name"] as! String] as! String
                self.lastName = data[K.db.UserFeilds.lastName["name"] as! String] as! String
                self.mobileNumber = data[K.db.UserFeilds.mobileNumber["name"] as! String] as! String

                self.balance = data[K.db.UserFeilds.balance["name"] as! String] as! Double
                self.points = data[K.db.UserFeilds.points["name"] as! String] as! Int
                self.type = data[K.db.UserFeilds.type["name"] as! String] as! Int
                

                print("clousre done")
            }else{
                print("ERROR")
            }
            print("all output begins...>")
            self.toString()
            print("all output done...<")
           
        }
    }
    
    func toString(){
        print("ID: \(ID)")
        print("firstName: \(firstName)")
        print("lastName: \(lastName)")
        print("mobileNumber \(mobileNumber)")
        print("balance \(balance)")
        print("points \(points)")
        print("type \(type)")
        print("locations \(locations)")
        print("creditCards \(creditCards)")
    }
}
