//
//  ShoppingCategory.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/2/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class ShoppingCategory{
    let ID:String
    let imageURLs:[String]?
    let name:[String:String]
    let subCategories: [ShoppingSubCategory]
    let hidden:Bool
    
    init(_ ID:String,_ imageURLs:[String]?,_ name:[String:String],_ subCategories:[ShoppingSubCategory],_ hidden:Bool) {
        
        self.ID = ID
        self.imageURLs = imageURLs
        self.name = name
        self.subCategories = subCategories
        self.hidden = hidden
        
    }
    
    init() {
        self.ID = ""
        self.imageURLs = []
        self.name = [:]
        self.subCategories = []
        self.hidden = true
    }
    
    func toString(){
        print("A Category:")
        print("ID: \(self.ID)")
        print("imageURLs: \(self.imageURLs)")
        print("name: \(self.name)")
        print("hidden: \(self.hidden)")
        for subCategory in self.subCategories {
            subCategory.toString()
        }
        
    }
}
