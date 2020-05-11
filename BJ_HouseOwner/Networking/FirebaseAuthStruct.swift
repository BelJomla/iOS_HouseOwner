//
//  FirebaseAuth.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/17/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit


struct FirebaseAuthStruct {
    
    static var user:User = User()
    
    static let auth = Auth.auth()
    static func sendVerficationMessage(forPhone phone:String, completion: @escaping (_ verificationCode:String)->()){
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                Logger.log(.error, " phone auth \(error.localizedDescription)")
                return
            }else{
                print("verification id: \(verificationID)")
                completion(verificationID!)
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }
    
    static func verifyCode(verificationID:String,verificationCode:String, isMFAEnabled:Bool , completion: @escaping (_ isSuccessful:Bool)->()){
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in (resolver.hints) {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
                } else {
                    Logger.log(.error, "Error:1 happend in the login process. (verification code might incorrect)")
                    completion(false)
                    return
                }
                // ...
                Logger.log(.error, "Error:2 User Not Signed IN. ")
                completion(false)
                return
            }
            // User is signed in
            // ...
            Logger.log(.success, "user signed ")
            completion(true)
        }
    }
    
    static func createNewUser(_ phoneNumber:String, _ firstName:String, _ lastName:String){
        //        FirebaseAuth.auth.createUser
    }
    static func signout(completion:@escaping (_ success:Bool)->()){
        let firebaseAuth = FirebaseAuthStruct.auth
        do {
            try firebaseAuth.signOut()
            completion(true)
        } catch let signOutError as NSError {
            Logger.log(.error, "Could not sign the user out")
            print ("Error signing out: %@", signOutError)
            completion(false)
        }
    }

    static func isUserSignedIn() -> Bool{
        let user = FirebaseAuthStruct.auth.currentUser
        if user != nil {
            // User is signed in.
            Logger.log(.info, "user is signed in wit id: \(user!.uid)")
            // print(FirebaseAuthStruct.auth.currentUser?.phoneNumber)
            return true
        } else {
            // No user is signed in.
            Logger.log(.warning
                , "user not signed in")
            return false
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
