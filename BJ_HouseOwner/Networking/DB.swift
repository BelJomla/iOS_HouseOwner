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
        
        DB.getDocument(with: "/users/\(id)"){
            data in
            
            let ID = data?["id"] as! String
            let firstName = data?["firstName"] as! String
            let lastName = data?["lastName"]  as! String
            let mobileNumber = data?["mobileNumber"] as! String
            
            let balance = data?["balance"] as! Double
            let points = data?["points"] as! Int
            let type = data?["type"] as! Int
            
            var locations = data?["locations"] as? [[String:Any]] ?? [UserLocation().asDictionary()]
            var creditCards = data?["creditCards"] as? [[String:Any]] ?? [CreditCard().asDictionary()]
            var convertedLocations:[UserLocation] = []
            var convertedCards:[CreditCard] = []
            
            
            for index in 0..<locations.count {
                
                let country = locations[index]["country"] as? String
                let city = locations[index]["city"] as? String
                let neightbour =  locations[index]["neighbour"] as? String
                let lat = locations[index]["lat"] as? String
                let long =  locations[index]["long"] as? String
                
                if  (country == nil || city == nil
                    || neightbour == nil ||  lat == nil || long == nil){
                    
                    Logger.log(.warning, "Incomplete Location Received From the DB [containing Nil]")
                    // making a default location that can't be used for actual delivery
                    locations[index] = UserLocation().asDictionary()
                    
                }else {
                    convertedLocations.append(UserLocation(country!, city!, neightbour!, lat!, long!, true))
                }
            }
            
            // iterating over each card and reading its info
            // and then creating a user instance of that at the end
            for index in 0..<creditCards.count {
                
                let holderName = creditCards[index]["holderName"] as? String
                let expireTimeStamp = creditCards[index]["expireDate"] as? Timestamp
                let cardNumber = creditCards[index]["cardNumber"] as? String
                let cvv = creditCards[index]["cvv"] as? String
                
                var expireDate:Date? = nil
                if let expireTimeStamp = expireTimeStamp {
                    expireDate = Date(timeIntervalSince1970: TimeInterval(expireTimeStamp.seconds))
                }
                
                // if any of the following is nil, the card is not accepted, and default values are assinged.
                // we can change this in the future
                if  (holderName == nil
                    || cardNumber == nil ||  cvv == nil || expireDate == nil) {
                    
                    creditCards[index] = CreditCard().asDictionary() // new empty card instance (can't be used)
                    Logger.log(.warning, "Invalid Credit Card Received from the DB [containing nil]")
                    
                }else{
                    convertedCards.append(CreditCard(holderName!, expireDate!, cardNumber!, cvv!, true))
                    Logger.log(.success, "All Feilds are correct for the Credit Card")
                }
                
            }
            
            let tempUser = User(ID, firstName, lastName, mobileNumber, balance, points, type, convertedLocations, convertedCards)
            user = tempUser
            
            print("\n\n-------> \n")
            user?.toString()
            print("\n-------< \n\n")
            
        }
        
        return user
    }
}


