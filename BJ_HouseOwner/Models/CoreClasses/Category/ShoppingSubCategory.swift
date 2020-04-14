//
//  ShoppingSubCategory.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/2/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class ShoppingSubCategory{
    let ID:String
    let imageURL:String?
    let name:[String:String]
    let hidden:Bool
    
    init(_ ID:String,_ imageURL:String?,_ name:[String:String],_ hidden:Bool) {
        self.ID = ID
        self.imageURL = imageURL
        self.name = name
        self.hidden = hidden
    }
    
    init() {
        self.ID = ""
        self.imageURL = ""
        self.name = [:]
        self.hidden = true
    }
    
    func toString(){
        print("A subcategory:")
        print(" -ID: \(self.ID)")
        print(" -imageURL: \(self.imageURL)")
        print(" -name: \(self.name)")
        print(" -hidden \(self.hidden)")
    }
}
