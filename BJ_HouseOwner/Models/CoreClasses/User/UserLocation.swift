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
    
    init(country:String,city:String,neighbour:String,lat:String,long:String) {
        self.country = country
        self.city = city
        self.neighbour = neighbour
        self.lat = lat
        self.long = long
    }
    
    init() {
        self.country = ""
        self.city = ""
        self.neighbour = ""
        self.lat = ""
        self.long = ""
    }
    
    func asDictionary() -> [String:String]{
        let dict = ["country":country,
                    "city":city,
                    "neighbour":neighbour,
                    "lat":lat,
                    "long":long]
        return dict
    }
    
    func toString(){
        
        print("- country: \(country)")
        print("- city: \(city)")
        print("- neighbour: \(neighbour)")
        print("- lat: \(lat)")
        print("- long: \(long)")
    }
    
}
