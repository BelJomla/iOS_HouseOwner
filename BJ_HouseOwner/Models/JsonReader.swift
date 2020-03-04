//
//  JsonReader.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/4/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


class JsonReader {
    
    
    static func readLocalJson <T: Decodable>(fileName:String,fileType:String, classType:T.Type)  -> T?{
           
           // this instance is going to parse json
           let decoder = JSONDecoder()
           // this path is String? and is the easiest wasy to locate a file
           let path = Bundle.main.path(forResource: fileName, ofType: fileType)
           // this url object is required to genrate Data object
           let url = URL(fileURLWithPath: path!)
           
           do{
               // this data object is needed for JSONDecoder object
               let data = try Data(contentsOf: url)
               // this is the result of the decoded json
               
            let decoded = try decoder.decode(classType, from: data )
               
               return decoded
               
           }catch {
           print(" could not parse json \n")
           print(error)
           return nil
       }
       }
    
}
