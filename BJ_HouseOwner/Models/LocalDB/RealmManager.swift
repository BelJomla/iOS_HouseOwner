//
//  RealmManager.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/21/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    
    private init() {} // not allowed to create new Objects of this class. It is singleton
    static let shared = RealmManager()
    
    var realm = try! Realm() // this instance will be accessed from outside
    
    func read<T:Object>(_ object:T.Type) -> Results<T>{
        return realm.objects(object)
    }
    
    func create<T: Object>(_ object: T){
        do{
            try realm.write(){
                realm.add(object)
            }
        }catch{
            Logger.log(.error, "RealmError: Could not write object. \n \(error)")
        }
    }
    
    func update<T: Object>(_ object: T, with newDictionary: [String:Any?]){
        do{
            try realm.write(){
                for (key, value) in newDictionary {
                    object.setValue(value, forKey: key)
                }
            }
        }catch{
            Logger.log(.error, "RealmError: Could not update object. \n \(error)")
        }
    }
    
    func delete<T:Object>(_ object:T){
        do{
            try realm.write(){
                realm.delete(object)
            }
        }catch{
            Logger.log(.error, "RealmError: Could not delete object. \n \(error)")
        }
    }
    
}
