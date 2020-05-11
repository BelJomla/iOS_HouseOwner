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
    
    struct UserDefaultsKeys{
        static let userIsSignedIn = "userIsSignedIn"
    }
    
    
    struct segues {
        struct profile {
            static let toSettings = "toProfileSettings"
            static let toCards = "toCards"
            static let toOrderHistory = "toOrderHistory"
            static let toAddresses = "toAddresses"
            static let toAddCreditCard = "addCreditCard"
        }
        struct loginProcess {
            static let toTabScreensWithoutRegistration = "toTabScreensWithoutRegistration"
            static let registerNewUser = "registerNewUser"
            static let directlyToTapScreens = "directlyToTapScreens"
            static let toLoginOrSignupProcess = "toLoginOrSignupProcess"
        }
        struct shoppingScreen{
            static let toCart = "toCartScreenFromShopping"
        }
        struct cartScreen{
            static let toCheckout = "fromCartToCheckout"
            static let toThankyouOrderPlaced = "toThankyouOrderPlaced"
        }
    }
    
    struct UITableCells {

            struct IDs {
                static let profileSettings = "profileSettingsCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
                static let creditCardCell = "creditCardCell"
                static let shoppingTableCell = "shoppingTableCell"
                static let cartCell = "cartCell"
                static let checkoutPaymentMethod = "paymentMethodCell"
                

            }
            struct nibNames {
                static let profileSettings = "SettingsTableViewCell"
                static let clickableSettingsCell = "ClickableSettingsTableViewCell"
                static let switchSettingsCell = "SwitchSettingsTableViewCell"
                static let creditCardCell = "MyCardsTableViewCell"
                static let shoppingTableCell = "shoppingTableCell"
                static let cartCell = "CartTableViewCell"
                static let checkoutPaymentMethod = "PaymentMethodTableViewCell"
            }
    }
    
    struct UICollectionCells {
        struct IDs {
            static let noProductCell = "NoProductsCell"
        }
        
        struct nibNames {
            static let noProductCell = "NoProductCollectionViewCell"
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


