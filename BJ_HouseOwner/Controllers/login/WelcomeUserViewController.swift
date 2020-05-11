//
//  WelcomeUserViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/8/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let dataRead = RealmManager.shared.read(User.self)
        let userIsSignedIn = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.userIsSignedIn)
        
        if userIsSignedIn && !dataRead.isEmpty{
            print("Link to open Realm Locally: \(Realm.Configuration.defaultConfiguration.fileURL)")
            
            let currentUserArr = RealmManager.shared.read(User.self)
            FirebaseAuthStruct.user = currentUserArr[currentUserArr.count-1]
//            FirebaseAuthStruct.user.toString()
            
            // directly forward the user to "TapScreens" since they are registerd
            performSegue(withIdentifier: K.segues.loginProcess.directlyToTapScreens, sender: self)
        }else{
            
            // let the user go through the login/singUp process
            performSegue(withIdentifier: K.segues.loginProcess.toLoginOrSignupProcess, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // styling
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        

    }
}
