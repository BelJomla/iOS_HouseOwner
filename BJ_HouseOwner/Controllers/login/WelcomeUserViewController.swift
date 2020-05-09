//
//  WelcomeUserViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 5/8/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class WelcomeUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //
        DB.getAllProducts(){
            products in
            for product in products {
                product.toString()
            }
        }
        //
        
        // Do any additional setup after loading the view.
        let dataRead = RealmManager.shared.read(User.self)
        let userIsSignedIn = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.userIsSignedIn)
        
        if userIsSignedIn && !dataRead.isEmpty{
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
