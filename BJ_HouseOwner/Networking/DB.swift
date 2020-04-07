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
    
    
    static func getDocument(with path:String, completion: @escaping (_ data:[String : Any]?)->() ){
        
        var data:[String : Any]? = nil
        
        
        let docRef = DB.db.document(path)
        
        docRef.getDocument { (documentSnapshot, error) in
            if let document = documentSnapshot, document.exists {
                
                let dataDescription = document.data()
                data = dataDescription
                
                completion(data)
                
            }else{
                print("\n\n\n\n------!!!----------")
                print(error!)
                print("\n\n\n\n-------!----------")
                assert(false, "Firebase Document Does Not Exist")
            }
        }
    }
    
    
    static func getUser(withID id:String) -> User?{
        var user:User?
        
        DB.getDocument(with: "/users/2P6ANOpEfUUkF3Q0gf5aJExnzJH3"){
            data in
            
            let ID = data?["id"] as! String
            let firstName = data?["firstName"] as! String
            let lastName = data?["lastName"]  as! String
            let mobileNumber = data?["mobileNumber"] as! String
            
            let balance = data?["balance"] as! Double
            let points = data?["points"] as! Int
            let type = data?["type"] as! Int
            
            var locations = data?["locations"] as? [[String:String]] ?? [UserLocation().asDictionary()]
            var creditCards = data?["creditCards"] as? [[String:Any]] ?? [CreditCard().asDictionary()]
            
            
            let convertedLocations:[UserLocation] = []
            var convertedCards:[CreditCard] = []
            
            
            for index in 0..<locations.count {
    
                
                let country = locations[index]["country"]
                let city = locations[index]["city"]
                let neightbour =  locations[index]["neighbour"]
                let lat = locations[index]["lat"]
                let long =  locations[index]["long"]
                
                
                if  country == nil || city == nil
                    || neightbour == nil ||  lat == nil || long == nil{
                    
                    print("INVALID LOCATION !!!")
                    locations[index] = UserLocation().asDictionary()
                    
                }else {
                   // same as card
                }
                
            }
            
            for index in 0..<creditCards.count {

                let holderName = creditCards[index]["holderName"] as? String
                let expireDate = creditCards[index]["expireDate"] as? Date ?? Date()
                let cardNumber = creditCards[index]["cardNumber"] as? String
                let cvv = creditCards[index]["cvv"] as? String
                
                
                if  holderName == nil
                    || cardNumber == nil ||  cvv == nil {
                    
                    
                    creditCards[index] = CreditCard().asDictionary()
                    print("INVALID CARD !!!")
                }else{
                    convertedCards.append(CreditCard(holderName!, expireDate, cardNumber!, cvv!))
                }
                
            }
        
            
            
            
            let tempUser = User(ID, firstName, lastName, mobileNumber, balance, points, type, convertedLocations, convertedCards)
            user = tempUser
            
            print(" - \n\n\n")
            user?.toString()
            print(" - - \n\n\n")
            
        }
        return user
    }
}


