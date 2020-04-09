//
//  userLocation.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/30/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


class UserLocation{
    let country:String
    let city:String
    let neighbour:String
    let lat:String // latitude
    let long:String // longtitude
    let isValid:Bool
    
    init(_ country:String,_ city:String,_ neighbour:String,_ lat:String,_ long:String, _ isValid:Bool) {
        self.country = country
        self.city = city
        self.neighbour = neighbour
        self.lat = lat
        self.long = long
        self.isValid = isValid
    }
    
    init() {
        self.country = ""
        self.city = ""
        self.neighbour = ""
        self.lat = ""
        self.long = ""
        self.isValid = false
    }
    
    func asDictionary() -> [String:Any]{
        let dict = ["country":country,
                    "city":city,
                    "neighbour":neighbour,
                    "lat":lat,
                    "long":long,
                    "isValid":isValid] as [String : Any]
        return dict
    }
    
    func toString(){
        print("- country: \(country)")
        print("- city: \(city)")
        print("- neighbour: \(neighbour)")
        print("- lat: \(lat)")
        print("- long: \(long)")
        print("- isValid: \(isValid)")
    }
    
}
