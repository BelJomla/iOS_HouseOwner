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
    let imageURL:String
    let name:[String:String]
    let hidden:Bool
    
    init(ID:String,imageURL:String,name:[String:String],hidden:Bool) {
        self.ID = ID
        self.imageURL = imageURL
        self.name = name
        self.hidden = hidden
    }
    
    
}
