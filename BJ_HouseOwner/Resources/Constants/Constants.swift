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
    
    
    struct segues {
        struct profile {
            static let toSettings = "toProfileSettings"
            static let toCards = "toCards"
            static let toOrderHistory = "toOrderHistory"
            static let toAddresses = "toAddresses"
            static let toAddCreditCard = "addCreditCard"
        }
        struct verifyScreen {
            static let toTabScreensWithoutRegistration = "directlyToTabScreens"
            static let registerNewUser = "registerNewUser"
        }
    }
    
    struct UITableCells {

            struct IDs {
                static let profileSettings = "profileSettingsCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
                static let creditCardCell = "creditCardCell"
            }
            struct nibNames {
                static let profileSettings = "SettingsTableViewCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
                static let creditCardCell = "MyCardsTableViewCell"
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


