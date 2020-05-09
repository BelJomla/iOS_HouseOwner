//
//  Order.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/6/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Order: Object {
    let products = List<Product>()
    
    dynamic var totalPrice = 0.0
    dynamic var discountPrice = 0.0
    dynamic var houseOwnerID = ""
    dynamic var orderID = ""
    dynamic var orderState = 0
    dynamic var finalPrice = 0.0
    
//    totalPrice discountPrice houseOwnerID orderID orderState finalPrice
    enum states:Int{
        case new = 0
        case pending = 1
        case inProgress = 2
        case completed = 3
        case cancelled = 4
    }
    
    func getTotalPrice () -> Double{
        var sum = 0.0
        for product in products{
            sum += product.sellingPrice * Double(product.wantedQuantity)
        }
        return sum
    }
    
    func updatePrice(){
        self.finalPrice = getTotalPrice()
        self.totalPrice = getTotalPrice()
        self.discountPrice = getTotalPrice()
        
    }
    
    convenience init(_ products:[Product],     _ houseOwnerID:String, _ orderID:String, _ orderState: states){
        self.init()
        self.houseOwnerID = houseOwnerID
        self.orderID = orderID
        self.orderState = orderState.rawValue

        for product in products{
            self.products.append(product)
        }
        self.updatePrice()
    }
    func toString(){
        print("An Order:")
        print("\ttotalPrice: \(totalPrice)")
        print("\tdiscountPrice:  \(discountPrice)")
        print("\thouseOwnerID: \(houseOwnerID)")
        print("\torderID: \(orderID)")
        print("\torderState: \(orderState)")
        print("\tfinalPrice: \(finalPrice)")
    }

}
