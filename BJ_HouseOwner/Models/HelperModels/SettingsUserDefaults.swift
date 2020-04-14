//
//  SettingsUserDefaults.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/14/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

class SettingsUserDefaults{
    
    enum supportedLanguages:String {
        case English = "en"
        case Arabic = "ar"
        case Urdu = "ur"
    }
    
    static let defualts = UserDefaults.standard
    
    static func restoreDefaultSetting(){
        //SettingsUserDefaults.defualts.
    }
    
    static func setPreferedLanguage(language:supportedLanguages){
        SettingsUserDefaults.defualts.set(language.rawValue, forKey: "language")
    }
}
