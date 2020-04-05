//
//  DB.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/31/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import Firebase


struct DB {
    static let db = Firestore.firestore()
    static let auth = Auth.auth()
    
    
    static func fetchCategory(withName name:String, completion: @escaping ( _ dataDocs:[[String:Any]])-> ()){
        
        var dataDocs:[[String:Any]] = [] // change this
        
        
        let colRef = DB.db.collection(name)
        
        colRef.getDocuments { (querySnapshot, error) in
            
            let numberOfDocs = querySnapshot?.count
            let docs = querySnapshot?.documents
            
            if let docs = docs, let numberOfDocs = numberOfDocs {
                if numberOfDocs > 0 {
                    for doc in docs {
                        var tempDoc:[String:Any] = [:]
                        
                        for field in K.db.CategoryFields.getAll(){
                            var defaultValue:Any? // in case wronge data type from db comes, we use this as a default one
                            let fieldName = field["name"] as! String
                            
                            defaultValue = field["defaultValue"]!
                            
                            if let receivedFieldData = doc[fieldName]{
                                print(defaultValue!)
                                print(type(of: defaultValue!))
                                
                                if defaultValue! is Double{
                                    tempDoc[fieldName] = receivedFieldData as? Double ?? defaultValue!
                                } else if defaultValue! is Bool{
                                    tempDoc[fieldName] = receivedFieldData as? Bool ?? defaultValue!
                                } else if defaultValue! is Int {
                                    tempDoc[fieldName] = receivedFieldData as? Int ?? defaultValue!
                                } else if defaultValue! is String {
                                    tempDoc[fieldName] = receivedFieldData as? String ?? defaultValue!
                                } else if defaultValue! is [String] {
                                    tempDoc[fieldName] = receivedFieldData as? [String] ?? defaultValue!
                                } else if defaultValue! is [String:Any] {
                                    tempDoc[fieldName] = receivedFieldData as? [String:String] ?? defaultValue!
                                } else if defaultValue! is [[String:Any]] {
                                    tempDoc[fieldName] = receivedFieldData as? [[String:Any]] ?? defaultValue!
                                }
                                else {
                                    assert(false, "Should not happen")
                                }
                                
                            }else{
                                tempDoc[fieldName] = defaultValue
                            }
                        }
                        dataDocs.append(tempDoc)
                    }
                }
            }
        }
        completion(dataDocs)
    }
}


//    static func fetchDocument(withID id: String, docRef:DocumentReference ,feilds:[[String : Any]],  completion: @escaping ( _ fetchedData:[String:Any]?)-> ()){
//
//        let docRef = DB.db.collection("collectionName").document(id)
//        var fetchedData:[String:Any]? = [:]
//
//
//        docRef.getDocument{  (documentSnapshot, error) in
//            if let e = error{
//                print("FIREBASE ERROR: \(e)")
//                fetchedData = nil
//            }
//            else{
//                if let documentSnapshot = documentSnapshot, documentSnapshot.exists{
//
//                    let data = documentSnapshot.data()
//
//                    if data == nil {
//                        // this is done again in the botton, it is redundant
//                        fetchedData = nil
//                        completion(fetchedData)
//                        return
//                    }
//
//                    for field in K.db.UserFeilds.getAll(){
//                        var defaultValue:Any? // in case wronge data type from db comes, we use this as a default one
//                        let fieldName = field["name"] as! String
//
//                        defaultValue = field["defaultValue"]!
//
//                        if let receivedFieldData = data![fieldName]{
//
//                            if defaultValue! is Double{
//                                fetchedData![fieldName] = receivedFieldData as? Double ?? defaultValue
//                            } else if defaultValue! is Bool{
//                                fetchedData![fieldName] = receivedFieldData as? Bool ?? defaultValue
//                            } else if defaultValue! is Int {
//                                fetchedData![fieldName] = receivedFieldData as? Int ?? defaultValue
//                            } else if defaultValue! is String {
//                                fetchedData![fieldName] = receivedFieldData as? String ?? defaultValue
//                            } else {
//                                assert(false, "No Data Type met, weird type received for the Database!")
//                            }
//
//
//                        }else{
//                            fetchedData![fieldName] = defaultValue
//                        }
//                    }
//                }else{
//                    fetchedData = nil
//                    completion(fetchedData)
//                    return
//                }
//                completion(fetchedData)
//            }
//        }
//    }


