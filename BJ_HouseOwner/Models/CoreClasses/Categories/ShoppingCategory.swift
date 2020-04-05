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
    let imageURLs:[String]
    let name:[String:String]
    let subCategories: [ShoppingSubCategory]
    
    init(ID:String,imageURLs:[String],name:[String:String],subCategories:[ShoppingSubCategory]) {
        
        self.ID = ID
        self.imageURLs = imageURLs
        self.name = name
        self.subCategories = subCategories
        
    }
    
}
