//
//  userLocation.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class UserLocation: Object{
    
    dynamic var country:String? = nil
    dynamic var city:String? = nil
    dynamic var neighbour:String? = nil
    dynamic var lat:Double? = nil // latitude
    dynamic var long:Double? = nil// longtitude
    dynamic var isValid:Bool = false
    
    convenience init(_ country:String?,_ city:String?,_ neighbour:String?,_ lat:Double?,_ long:Double?, _ isValid:Bool) {
        self.init() // realm constructor
        
        self.country = country
        self.city = city
        self.neighbour = neighbour
        self.lat = lat
        self.long = long
        self.isValid = isValid
    }
    
    convenience init(_ ignore:String?) {
        self.init()
        
        self.country = ""
        self.city = ""
        self.neighbour = ""
        self.lat = 0
        self.long = 0
        self.isValid = false
    }
    
    func asDictionary() -> [String:Any]{
        let dict = ["country":country as Any,
                    "city":city as Any,
                    "neighbour":neighbour as Any,
                    "lat":lat as Any,
                    "long":long as Any,
                    "isValid":isValid] as [String : Any]
        return dict
    }
    
    func toString(){
        print("- country: \(String(describing: country))")
        print("- city: \(String(describing: city))")
        print("- neighbour: \(String(describing: neighbour) )")
        print("- lat: \(String(describing: lat))")
        print("- long: \(String(describing: long))")
        print("- isValid: \(isValid)")
    }
    
}
