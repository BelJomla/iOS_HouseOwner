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
                Logger.log(.warning, "Request Document Does not exist")
            }
            if let error = error {
                Logger.log(.error, "Firebase Error: \n\(error)")
            }
            
        }
    }
    
    static func getDocuments(with collectionName:String, completion: @escaping (_ data:[Any]?)->()){
        
        var data:[[String:Any]]? = nil
        let collectionRef = DB.db.collection(collectionName)
        
        collectionRef.getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot, !querySnapshot.isEmpty{
                Logger.log(.success, "Collection Read successfully")
                data = []
                
                let documents = querySnapshot.documents
                
                for document in documents {
                    data?.append(document.data())
                }
                completion(data)
                
            }else{
                Logger.log(.error, "NO Documents Found in Collection")
            }
            if let error = error {
                Logger.log(.error, "Firebase Error: \n\(error)")
            }
        }
    }
    
    static func getCategories(completion: @escaping (_ categories:[ShoppingCategory])->()) {
        let collectionName = "categories"
        var categories:[ShoppingCategory] = []
        
        DB.getDocuments(with: collectionName){
            data in
            
            let documents = data as! [[String:Any]]?
            var errorFlag = true
            if let documents = documents {
                for document in documents {
                    // document here is a category
                    guard let ID = document["id"] as? String else {return}
                    guard let name = document["name"] as? [String:String] else {return}
                    guard let imageURLs = document["imgURLs"]  as? [String] else {return}
                    guard let hidden = document["hidden"] as? Bool else {return}
                    
                    var subCategories:[ShoppingSubCategory] = []
                    let subCategoriesDB = document["subCategories"] as! [[String:Any]]
                    let innerErrorFlag = true
                    
                    for i in 0..<subCategoriesDB.count{
                        
                        let subCat = subCategoriesDB[i]
                        let subID = subCat["id"] as! String
                        let subImageURL = subCat["imgURL"] as? String
                        let subName = subCat["name"] as! [String:String]
                        let subHidden = subCat["hidden"] as? Bool ?? true
                        
                        let subCategory = ShoppingSubCategory(subID, subImageURL, subName, subHidden)
                        subCategories.append(subCategory)
                    }
                    if innerErrorFlag {
                        Logger.log(.warning, "One of the subcategories is missing some fields")
                    }
                    errorFlag = false // no error happend
                    let category = ShoppingCategory(ID, imageURLs, name,  subCategories, hidden)
                    categories.append(category)
                    errorFlag = false
                }
                completion(categories)
                
                if (errorFlag) {
                    Logger.log(.error, "Error In Reading Categories From The DB #1")
                }
            }else{
                Logger.log(.error, "Error In Reading Categories From The DB #2")
            }
        }
    }
    
    static func getUser(withID id:String, completion:@escaping (_ user:User?)->()){
        var user:User?
        
        DB.getDocument(with: "/users/\(id)"){
            data in
            
            user = DB.parseUser(data)
            completion(user)
        }
    }
    
    static func getUser(withPhone phone:String, completion: @escaping (_ user:User?)->()){
        getDocuments(collectionName: "users", whereField: "mobileNumber", isEqualToValue: phone){
            data in
            // data[0] since we are expecting phone number to act as the primary key
            
            var user:User? = nil
            if data.isEmpty {
                Logger.log(.error, "user not found in DB")
            }else{
                user = parseUser(data[0])
            }
            completion(user)
        }
    }
    
    static func parseUser(_ data:[String : Any]?)->User?{
        
        let ID = data?["id"] as! String
        let firstName = data?["firstName"] as! String
        let lastName = data?["lastName"]  as! String
        let mobileNumber = data?["mobileNumber"] as! String
        
        let balance = data?["balance"] as! Double
        let points = data?["points"] as! Int
        let type = data?["type"] as! Int
        
        let locations = data?["locations"] as? [[String:Any]] ?? [UserLocation().asDictionary()]
        var creditCards = data?["creditCards"] as? [[String:Any]] ?? [CreditCard().asDictionary()]
        var convertedLocations:[UserLocation] = []
        var convertedCards:[CreditCard] = []
        
        for index in 0..<locations.count {
            
            let country = locations[index]["country"] as? String
            let city = locations[index]["city"] as? String
            let neightbour =  locations[index]["neighbour"] as? String
            //                let lat = locations[index]["lat"] as? String
            //                let long =  locations[index]["long"] as? String
            let coordinates = locations[index]["coordinates"] as? GeoPoint
            let lat = coordinates?.latitude
            let long = coordinates?.longitude
            Logger.log(.info, "lat: \(String(describing: lat))")
            Logger.log(.info, "long: \(String(describing: long))")
            
            if  (country == nil || city == nil
                || neightbour == nil ||  coordinates == nil){
                
                Logger.log(.warning, "Incomplete Location Received From the DB [containing Nil]")
                
                if (country == nil){
                    print("\tCountry is Nil")
                }
                if (city == nil){
                    print("\tCity is Nil")
                }
                if (neightbour == nil){
                    print("\tNeightbour is Nil")
                }
                if (coordinates == nil){
                    print("\tCoordinates is Nil")
                }
                
                // making a default location that can't be used for actual delivery
                // locations[index] = UserLocation().asDictionary()
                convertedLocations.append(UserLocation(country, city, neightbour, lat, long, false))
                
            }else {
                convertedLocations.append(UserLocation(country!, city!, neightbour!, lat, long, true))
            }
        }
        
        // iterating over each card and reading its info
        // and then creating a user instance of that at the end
        for index in 0..<creditCards.count {
            
            let holderName = creditCards[index]["holderName"] as? String
            let expireTimeStamp = creditCards[index]["expireDate"] as? Timestamp
            let cardNumber = creditCards[index]["cardNumber"] as? String
            let cvv = creditCards[index]["cvv"] as? Int
            
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
                
                if (holderName == nil){
                    print("\tHolderName is Nil")
                }
                if (cardNumber == nil){
                    print("\tCardNumber is Nil")
                }
                if (cvv == nil){
                    print("\tCvv is Nil")
                }
                if (expireDate == nil){
                    print("\tExpireDate is Nil")
                }
                
                
            }else{
                convertedCards.append(CreditCard(holderName!, expireDate!, cardNumber!, String(cvv!), true))
                Logger.log(.success, "All Feilds are correct for the Credit Card")
            }
        }
        let user = User(ID, firstName, lastName, mobileNumber, balance, points, type, convertedLocations, convertedCards)
        //        user = tempUser
        //        completion(user)
        return user
        
    }
    
    static func getDocuments( collectionName:String, whereField field:String, isEqualToValue value:String,  completion: @escaping (_ documents:[[String:Any]])->()){
        let collectionRef = DB.db.collection(collectionName)
        let query = collectionRef.whereField(field, isEqualTo: value)
        var documents:[[String:Any]] = []
        
        query.getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                for document in querySnapshot.documents {
                    documents.append(document.data())
                }
                completion(documents)
            }else{
                Logger.log(.error, "Requested querySnapshot is empty")
                completion(documents)
            }
            if let error = error {
                
                Logger.log(.error, "Error in executing firebase query on \(collectionName) FIREBASE ERROR:\n\(error)")
                completion(documents)
            }
        }
    }
    
    
    static func getProducts(withSubCollectionID ID:String, completion: @escaping (_ products: [Product])->()){
        var products: [Product] = []
        
        DB.getDocuments(collectionName: "products", whereField: "subCategory", isEqualToValue: ID){
            documents in
            
            for document in documents {
                let ID = document["id"] as! String
                let category = document["category"] as! String
                let subCategory = document["subCategory"] as! String
                let sellingPrice = document["sellingPrice"] as! Double
                let imageURLs = document["imgURLs"] as! [String]
                
                let name = document["name"] as! [String:String]
                let companyName = document["companyName"] as! [String:String]
                let qualitativeSize = document["qualititveSize"] as! [String:String]
                let quantitativeSize = document["quantativeSize"] as! [String:String]
                
                let oneProduct = Product.optionalInit(ID, category, subCategory, sellingPrice, imageURLs, name, companyName, qualitativeSize, quantitativeSize, nil)
                
                products.append(oneProduct)
            }
            completion(products)
        }
    }
    
    static func getProducts(withCollectionID ID:String, completion: @escaping (_ products: [Product])->()){
        var products: [Product] = []
        
        DB.getDocuments(collectionName: "products", whereField: "category", isEqualToValue: ID){
            documents in
            
            for document in documents {
                let ID = document["id"] as! String
                let category = document["category"] as! String
                let subCategory = document["subCategory"] as! String
                let sellingPrice = document["sellingPrice"] as! Double
                let imageURLs = document["imgURLs"] as! [String]
                
                let name = document["name"] as! [String:String]
                let companyName = document["companyName"] as! [String:String]
                let qualitativeSize = document["qualititveSize"] as! [String:String]
                let quantitativeSize = document["quantativeSize"] as! [String:String]
                
                let oneProduct = Product.optionalInit(ID, category, subCategory, sellingPrice, imageURLs, name, companyName, qualitativeSize, quantitativeSize, nil)
                
                products.append(oneProduct)
            }
            completion(products)
        }
    }
    
    static func getAllProducts(completion: @escaping (_ products: [Product])->()){
        var products: [Product] = []
        
        DB.getDocuments(with: "products"){
            data in
            
            let documents = data as! [[String:Any]]?
            
            for document in documents! {
                let ID = document["id"] as! String
                let category = document["category"] as! String
                let subCategory = document["subCategory"] as! String
                let sellingPrice = document["sellingPrice"] as! Double
                let imageURLs = document["imgURLs"] as! [String]
                
                let name = document["name"] as! [String:String]
                let companyName = document["companyName"] as! [String:String]
                let qualitativeSize = document["qualititveSize"] as! [String:String]
                let quantitativeSize = document["quantativeSize"] as! [String:String]
                
                let oneProduct = Product.optionalInit(ID, category, subCategory, sellingPrice, imageURLs, name, companyName, qualitativeSize, quantitativeSize, nil)
                
                products.append(oneProduct)
            }
            completion(products)
        }
    }
    
    static func getUserIfExists(withPhone phone:String, completion:@escaping (_ userIsFound:Bool,_ user:User?)->()){
        DB.getDocuments(collectionName: "users", whereField: "mobileNumber", isEqualToValue: phone){
            documents in
            
            var user:User? = nil
            var userIsFound:Bool = false
            if documents.isEmpty{
                // user is not registered
                Logger.log(.info, "looks like the user is not registered")
            }else{
                // user is registered
                Logger.log(.info, "horay! the user has been found!")
                userIsFound = true
                user = DB.parseUser(documents[0])
            }
            completion(userIsFound,user)
        }
    }
    
    static func writeUserOrder(order:Order){
        
        var errorOccured = false
        var productData: [[String:Any]] = []
        
        let currentUserArr = RealmManager.shared.read(User.self)
        let currentUser = currentUserArr[currentUserArr.count-1]
        
        let products = Array(order.products)
        let newDocumentID = db.collection("orders").document().documentID
        
        for product in products{
            productData.append( ["product" : [
                "category" : String(product.category),
                "id" : product.ID,
                "imgURLs" : Array(product.imageURLs), // array
                "name" : product.getNameAsKeyValue(),
                "qualitiveSize" : product.getqualitativeSizeAsKeyValue(),
                "quantativeSize" : product.quantitativeSizeAsKeyValue(),
                "sellingPrice" : product.sellingPrice,
                "subCategory": product.subCategory,
                ], "quantity":product.wantedQuantity])
        }
        
        let docData: [String: Any] = [
            "cart" : [
                "items" : productData// array
            ], // map
            "city" : "Dammam",
            "country" : "Saudi Arabia",
            "coupon" : "",
            "date" : Timestamp(date: Date()),
            "deliveryLocation" : [
                "city" :  "Dammam",
                "country" : currentUser.locations[0].country ?? "!!!",
                "description" : currentUser.locations[0].description ?? "!!!",
                "lat" : currentUser.locations[0].lat ?? 88,
                "long" : currentUser.locations[0].long ?? 88,
                "name" : "???",//currentUser.locations[0].description ?? "!!!",
                "neighbor": currentUser.locations[0].neighbour ?? "!!!",
            ], // map
            "deliveryPeriod" : 0,
            "deliveryPersonID" : "???",
            "discountPrice": order.totalPrice,
            "finalPrice" : 0,
            "houseOwnerID" : currentUser.ID,//currentUser.ID,
            "orderID" : newDocumentID,
            "orderState" : 0,
            "payedAmount" : order.getTotalPrice(),
            "paymentMethod" : -1,
            "reigon" : "reigon1",
            "time": Timestamp(date: Date()),
            "totalPrice" : order.getTotalPrice(),//order.totalPrice,
            "wsslocaiton" : [] // array
            
        ]
        
        db.collection("orders").document(newDocumentID).setData(docData)
        
        if (!errorOccured) {
            print("Document added with ID:.. \(newDocumentID)") //\(newDocumentRef!.documentID)
        }
    }
}

// this will be used to forward the user to get his info, or just login.
// to do next
// correct back the categories
// get back adding items to the cart
// logout, related to Auth, and use userDefualts when the user logs in, so that phon verify is not required everytime
// profile data assignmet
// correctly loading the products, using get product by subcategory
// add simple animations



