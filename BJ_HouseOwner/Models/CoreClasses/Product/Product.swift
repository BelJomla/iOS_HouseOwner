//
//  Product.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/13/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Product:Object {
    dynamic var ID:String = ""
    dynamic var category:String = ""
    dynamic var subCategory:String = ""
    dynamic var sellingPrice:Double = 0.0
    
    let imageURLs = List<String>()
    
    dynamic let name = List<productName>()
    dynamic let companyName = List<productCompanyName>()
    dynamic let qualitativeSize = List<productQualitativeSize>()
    
    dynamic let quantitativeSize = List<productQuantitativeSize>()
    /*
     wantedQuantity is only used when when the user orders
     */
    dynamic var wantedQuantity:Int = 8//-1
    
    convenience init(_ ID:String,_ category:String, _ subCategory:String,_ sellingPrice:Double, _ imageURLs:[String], _ name:[String:String], _ companyName:[String:String], _ qualitativeSize:[String:String], _ quantitativeSize:[String:String], _ wantedQuantity:Int) {
        self.init()
        
        
        self.ID = ID
        self.category = category
        self.subCategory = subCategory
        self.sellingPrice = sellingPrice
        
        for imageURL in imageURLs{
            self.imageURLs.append(imageURL)
        }
        for langName in name {
            let prouctNameInstance = productName(key: langName.key, value: langName.value)
            self.name.append(prouctNameInstance)
        }
        for compName in companyName {
            let compNameInstance = productCompanyName(key: compName.key, value: compName.value)
            self.companyName.append(compNameInstance)
        }
        
        for qualSize in qualitativeSize {
            let productQualInstance = productQualitativeSize(key: qualSize.key, value: qualSize.value)
            self.qualitativeSize.append(productQualInstance)
        }
        
        for quanSize in quantitativeSize {
            let productQuanInstance = productQuantitativeSize(key: quanSize.key, value: quanSize.value)
            self.quantitativeSize.append(productQuanInstance)
        }
        
        self.wantedQuantity = wantedQuantity
    }
    
    static func optionalInit(_ ID:String,_ category:String?, _ subCategory:String?,_ sellingPrice:Double, _ imageURLs:[String]?, _ name:[String:String]?, _ companyName:[String:String]?, _ qualitativeSize:[String:String]?, _ quantitativeSize:[String:String]?, _ wantedQuantity:Int?)->Product{
        self.init()
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
        var _wantedQuantity:Int = 12//12//-1
        
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
            _quantitativeSize = quantitativeSize!
        }
        if wantedQuantity == nil {
            _wantedQuantity = 12 //12 //-1
        }
        
        return Product(ID, _category, _subCategory, sellingPrice, _imageURLs, _name, _companyName, _qualitativeSize, _quantitativeSize, _wantedQuantity)
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
        print("wantedQuantity: \(wantedQuantity)")
    }
    
    func getNameAsKeyValue()-> [String:String]{
        let list = self.name
        var dict:[String:String] = [:]
        for item in list{
            dict[item.key] = item.value
        }
        return dict
    }
    func getCompanyNameAsKeyValue() -> [String:String] {
        let list = self.companyName
        var dict:[String:String] = [:]
        for item in list{
            dict[item.key] = item.value
        }
        return dict
    }
    func getqualitativeSizeAsKeyValue() -> [String:String] {
        let list = self.qualitativeSize
        var dict:[String:String] = [:]
        for item in list{
            dict[item.key] = item.value
        }
        return dict
    }
    func quantitativeSizeAsKeyValue() -> [String:String] {
        let list = self.quantitativeSize
        var dict:[String:String] = [:]
        for item in list{
            dict[item.key] = item.value
        }
        return dict
    }
    
}

@objcMembers class productName:Object {
    dynamic var key = ""
    dynamic var value = ""
    convenience init(key:String, value:String){
        self.init()
        self.key = key
        self.value = value
    }
}
@objcMembers class productCompanyName:Object {
    dynamic var key = ""
    dynamic var value = ""
    convenience init(key:String, value:String){
        self.init()
        self.key = key
        self.value = value
    }
}
@objcMembers class productQualitativeSize:Object{
    dynamic var key = ""
    dynamic var value = ""
    convenience init(key:String, value:String){
        self.init()
        self.key = key
        self.value = value
    }
}
@objcMembers class productQuantitativeSize:Object{
    dynamic var key = ""
    dynamic var value = ""
    convenience init(key:String, value:String){
        self.init()
        self.key = key
        self.value = value
    }
}
