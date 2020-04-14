//
//  Product.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/13/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class Product {
    let ID:String
    let category:String
    let subCategory:String
    let sellingPrice:Double
    
    let imageURLs:[String]
    let name:[String:String]
    
    let companyName:[String:String]
    let qualitativeSize:[String:String]
    let quantitativeSize:[String:String]
    
    init(_ ID:String,_ category:String, _ subCategory:String,_ sellingPrice:Double, _ imageURLs:[String], _ name:[String:String], _ companyName:[String:String], _ qualitativeSize:[String:String], _ quantitativeSize:[String:String]) {
        self.ID = ID
        self.category = category
        self.subCategory = subCategory
        self.sellingPrice = sellingPrice
        self.imageURLs = imageURLs
        self.name = name
        self.companyName = companyName
        self.qualitativeSize = qualitativeSize
        self.quantitativeSize = quantitativeSize
    }
    
    static func optionalInit(_ ID:String,_ category:String?, _ subCategory:String?,_ sellingPrice:Double, _ imageURLs:[String]?, _ name:[String:String]?, _ companyName:[String:String]?, _ qualitativeSize:[String:String]?, _ quantitativeSize:[String:String]?)->Product{
        
        //         The following two variable are not allowed to be nil
        //           let ID:String
        //           let _sellingPrice:Double
        let _category:String
        let _subCategory:String
        
        
        let _imageURLs:[String]
        let _name:[String:String]
        
        let _companyName:[String:String]
        let _qualitativeSize:[String:String]
        let _quantitativeSize:[String:String]
        
        if category == nil {
            _category = "1"
        }else{
            _category = category!
        }
        if subCategory == nil {
            _subCategory = "1_1"
        }else{
            _subCategory = subCategory!
        }
        if imageURLs == nil {
            _imageURLs = ["https://www.agriculturenigeria.com/wp-content/uploads/2020/01/orange-1-770x389.jpg"]
        }else{
            _imageURLs = imageURLs!
        }
        if name == nil {
            _name = ["ar":"منتج جديد", "en":"new product"]
        }else{
            _name = name!
        }
        if companyName == nil {
            _companyName = ["en":"Beljmola.com", "ar":"بالجملة دوت كوم"]
        }else{
            _companyName = companyName!
        }
        if qualitativeSize == nil {
            _qualitativeSize = ["ar":"عادي", "en": "normal"]
        }else{
            _qualitativeSize = qualitativeSize!
        }
        
        if quantitativeSize == nil {
            _quantitativeSize = ["ar": "0 كغ", "en":"0 kg"]
        }else{
            _quantitativeSize = qualitativeSize!
        }
        
        return Product(ID, _category, _subCategory, sellingPrice, _imageURLs, _name, _companyName, _qualitativeSize, _quantitativeSize)
    }
    
    func toString(){
        print("ID: \(ID)")
        print("category: \(category)")
        print("subCategory: \(subCategory)")
        print("sellingPrice: \(sellingPrice)")
        print("imageURLs: \(imageURLs)")
        print("name: \(name)")
        print("companyName: \(companyName)")
        print("qualitativeSize: \(quantitativeSize)")
        print("quantitativeSize: \(quantitativeSize)")
    }
    
}
