////
////  User.swift
////  BJ_HouseOwner
////
////  Created by Project X on 3/30/20.
////  Copyright © 2020 beljomla.com. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//
//class UserDB {
//
//    static func fetchUserDocument(withID id: String,  completion: @escaping ( _ userData:[String:Any]?)-> ()){
//
//        let docRef = DB.db.collection(K.db.UserCollection.name).document(id)
//        var userData:[String:Any]? = [:]
//
//
//        docRef.getDocument{  (documentSnapshot, error) in
//            if let e = error{
//                print("FIREBASE ERROR: \(e)")
//                userData = nil
//            }
//            else{
//                if let documentSnapshot = documentSnapshot, documentSnapshot.exists{
//
//                    let data = documentSnapshot.data()
//
//                    if data == nil {
//                        // this is done again in the botton, it is redundant
//                        userData = nil
//                        completion(userData)
//                        return
//                    }
//
////                    for field in K.db.UserFeilds.getAll(){
//                        var defaultValue:Any? // in case wronge data type from db comes, we use this as a default one
//                        let fieldName = field["name"] as! String
//
//                        defaultValue = field["defaultValue"]!
//                        //
//                        // data is documentSnapshot.data()
//                        // fieldName is a String for field name
//                        if let receivedFieldData = data![fieldName]{
//                            print(defaultValue!)
//                            print(type(of: defaultValue!))
//
//                            if defaultValue! is Double{
//                                userData![fieldName] = receivedFieldData as? Double ?? defaultValue
//                            } else if defaultValue! is Bool{
//                                userData![fieldName] = receivedFieldData as? Bool ?? defaultValue
//                            } else if defaultValue! is Int {
//                                userData![fieldName] = receivedFieldData as? Int ?? defaultValue
//                            } else if defaultValue! is String {
//                                userData![fieldName] = receivedFieldData as? String ?? defaultValue
//                            } else {
//                                assert(false, "No Data Type met")
//                            }
//
//                        }else{
//                            userData![fieldName] = defaultValue
//                        }
//                    }
//                }else{
//                    userData = nil
//                    completion(userData)
//                    return
//                }
//                completion(userData)
//            }
//        }
//    }
//}
//
