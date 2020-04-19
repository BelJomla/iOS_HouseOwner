//
//  constants.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/17/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//
import CoreGraphics

struct K {
    // CGFloat only availbe in CoreGraphics
    static let cornerRadius:CGFloat = 10.0
    // testing new branch
    // testing xcode source control
    
    // segues
    static let verifyPhoneSegue = "verifyPhone"
    static let registerNewUser = "startApp"
    
    struct segues {
        struct profile {
            static let toSettings = "toProfileSettings"
            static let toCards = "toCards"
            static let toOrderHistory = "toOrderHistory"
            static let toAddresses = "toAddresses"
        }
    }
    
    struct UITableCells {

            struct IDs {
                static let profileSettings = "profileSettingsCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
            }
            struct nibNames {
                static let profileSettings = "SettingsTableViewCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
            }
    }
    
    //identifiers
    static let shoppingTableCell = "shoppingTableCell"
    static let shoppingCollectionCell = "shippingCollectionCell"
    static let shoppingProductCell = "productCell"
    
    struct UI{
        static let ordersCellID = "orderCell"
        static let ordersCellNibName = "OrdersTableViewCell"
        static let ordersInnerCellID  = "SomeID"
        static let ordersInnerCellNibName = "InnerOrderTableViewCell"
    }
    
    struct db {
        struct CategoriesCollection{
            static let name = "categories"
        }

    }
    
}


        
//        struct UserCollection {
//            static let name = "users"
//        }
//        struct UserFeilds {
//            static let ID:[String:Any] = ["name":"id","defaultValue":String()]
//            static let firstName:[String:Any] = ["name":"firstName","defaultValue":String()]
//            static let lastName:[String:Any] = ["name":"lastName","defaultValue":String()]
//            static let mobileNumber:[String:Any] = ["name":"mobileNumber","defaultValue":String()]
//
//            static let locations:[String:Any] = ["name":"locations","defaultValue":String()]
//            static let creditCards:[String:Any] = ["name":"creditCards","defaultValue":String()]
//
//            static let balance:[String:Any] = ["name":"balance","defaultValue":Double()]
//            static let points:[String:Any] = ["name":"points","defaultValue":Int()]
//            static let type:[String:Any] = ["name":"type","defaultValue":Int()]
//
//            static func getAll() -> [[String:Any]]{
//                return [ID,firstName,lastName,mobileNumber,balance,points,type,type,locations,creditCards]
//            }
//        }


//        struct CategoryFields{
//
//            static let imageURLs:[String:Any] = ["name":"imgURLs","defaultValue":["g.com"]]
//            static let name:[String:Any] = ["name":"name","defaultValue":["English":"Eggs"]]
//            static let hidden:[String:Any] = ["name":"hidden","defaultValue":false]
//            static let ID:[String:Any] = ["name":"id","defaultValue":"1"]
//
//            static let _defualtSubCategoryValue:[String:Any] = ["hidden":false,"id":"1_1","imgURL":"g.com","name":["English":"subEggs"]]
//            struct subCategory{
//                static let imageURL:[String:Any] = ["name":"imgURL","defaultValue":"g.com"]
//                static let name:[String:Any] = ["name":"name","defaultValue":["English":"subEggs"]]
//                static let hidden:[String:Any] = ["name":"hidden","defaultValue":false]
//                static let ID:[String:Any] = ["name":"id","defaultValue":"1_1"]
//            }
//            static let subCategories:[String:Any] = ["name":"subCategories","defaultValue":[K.db.CategoryFields._defualtSubCategoryValue]]
//
//            static func getAll() -> [[String:Any]]{
//                return [hidden,imageURLs,name,subCategories]
//            }
//        }
