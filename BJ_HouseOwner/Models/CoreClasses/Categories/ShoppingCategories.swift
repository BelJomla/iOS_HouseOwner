//
//  ShoppingCategory.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/1/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class ShoppingCategories {
    var categories:[ShoppingCategory]
    
    init(withName name:String){
        
        self.categories = []
        
        DB.fetchCategory(withName: name){dataDocs in
            //self.ID = dataDocs[K.db.CategoryFields.hidden["name"] as! String] as! Bool
            
            for doc in dataDocs{
                let ID = doc[K.db.CategoryFields.ID["name"] as! String] as! String
                let imageURLs = doc[K.db.CategoryFields.imageURLs["name"] as! String] as! [String]
                let name = doc[K.db.CategoryFields.name["name"] as! String] as! [String:String]
                let subCategories = doc[K.db.CategoryFields.subCategories["name"] as! String]  as! [[String:Any]]
                var subCategoryObjects:[ShoppingSubCategory] = []
                
                for subCategory in subCategories{
                    let subID:String = subCategory[K.db.CategoryFields.subCategory.ID["name"] as! String] as! String
                    let subImageURL:String = subCategory[K.db.CategoryFields.subCategory.imageURL["name"] as! String] as! String
                    let subName:[String:String] = subCategory[K.db.CategoryFields.subCategory.name["name"] as! String] as! [String : String]
                    let subHidden:Bool = (subCategory[K.db.CategoryFields.subCategory.hidden["name"] as! String] != nil)
                    
                    let subCategoryObject = ShoppingSubCategory(ID: subID, imageURL: subImageURL, name: subName,hidden: subHidden)
                    subCategoryObjects.append(subCategoryObject)
                }
                
                self.categories.append(ShoppingCategory(ID: ID , imageURLs: imageURLs, name: name, subCategories: subCategoryObjects))
            }
        }
        
    }
}
