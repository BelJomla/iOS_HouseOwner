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


struct FirebaseAuth {
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
    
}
