//
//  SignUpController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/17/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit


class SignUpController: UIViewController{
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstNameTextFeild: UITextField!
    @IBOutlet weak var lastNameTextFeild: UITextField!
    @IBAction func SignUpPressed(_ sender: UIButton) {
        
        if let firstNameTextFeildText = firstNameTextFeild.text, let lastNameTextFeildText = lastNameTextFeild.text {
            
            if ( firstNameTextFeildText == "" || lastNameTextFeildText == "" ){
                okAlert(title: "Information Needed", message: "We need your name, so we can register you in our system", viewController: self)
            }else{
                // info entered
            }
            
        }else{
            okAlert(title: "Information Needed", message: "We need your name, so we can register you in our system", viewController: self)
        }
        
        FirebaseAuthStruct.user.firstName = firstNameLabel.text!
        FirebaseAuthStruct.user.lastName = lastNameLabel.text!
        RealmManager.shared.create(FirebaseAuthStruct.user)
        DB.writeUser(user: FirebaseAuthStruct.user)
        UserDefaults.standard.set(true, forKey: K.UserDefaultsKeys.userIsSignedIn)
        // style
        self.navigationController?.navigationBar.isHidden = true
        performSegue(withIdentifier: "ToTabScreens", sender: self)
        
        // register user in Firestore
        
    }
    
    override func viewDidLoad() {
        styleUI()
        navigationItem.hidesBackButton = true
        print("Singup Screens")
        //FirebaseAuthStruct.isUserSignedIn()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    func okAlert(title:String, message:String, viewController:UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        viewController.present(alert, animated: true, completion: nil)
    }
   
    func styleUI(){
        self.navigationItem.hidesBackButton = true

    
        button.backgroundColor = UIColor(rgb: Colors.darkBlue)
        firstNameLabel.textColor = UIColor(rgb: Colors.darkBlue)
        lastNameLabel.textColor = UIColor(rgb: Colors.darkBlue)
        navigationController?.navigationBar.backgroundColor = UIColor(rgb: Colors.darkBlue)
        view.backgroundColor = UIColor(rgb: Colors.darkBlue)
        
        button.layer.cornerRadius = 10
        firstNameTextFeild.addBottomBorder()
        lastNameTextFeild.addBottomBorder()
        
        mainView.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        firstNameTextFeild.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        lastNameTextFeild.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        let navBar = self.navigationController?.navigationBar
        
         mainView.layer.cornerRadius = 50
    }
}


extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height + 5, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}



