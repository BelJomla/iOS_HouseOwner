//
//  VerifyViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/18/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class VerifyViewController: UIViewController{
    
    @IBOutlet weak var upperMessageLabel: UILabel!
    @IBOutlet weak var verifyTextFeild: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var checkmarkIcon: UIImageView!
    
    var phoneNumber:String = ""
    let countDownTime = 3 // seconds to wait before resend button appear
    var countDownTimeCurrent = 3 // current progress in the
    var timer:Timer = Timer()
    let maxNumberOfResending = 2
    var numberOfTimesResendPressed = 0
    var messageSendingRequested = false
    var verificationID = ""
    
    
    override func viewDidLoad() {
//        UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.userIsSignedIn)
        
        verifyTextFeild.delegate = self
        resendButton.isHidden = true
        styleUI()
        okAlert("reCAPTCHA verfication", "We will verifiy that you are not a robot, until the final release of the app, when we use PushNotifications",{
            
            self.sendVerificationCode(forPhone: self.phoneNumber)
            self.decreaseTimer()
        })
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func verifyButtonPressed(_ sender: Any) {
        if(!messageSendingRequested){
            // message not requested yet from firebase
            Logger.log(.warning, "user clicked vetify before the sms message is requested from firebase")
        }else{
            if let enteredCode = verifyTextFeild?.text {
                if enteredCode == "" {
                    okAlert( "Code Needed", "Please enter the verfication code", nil)
                }else{
                    // some code entered (may not be correct)
                    //let verificationCode = "111222"
                    verifyCode(verificationCode: enteredCode , verificationID: self.verificationID){
                        isSuccessful in
                        
                        if isSuccessful{
                            // testing
//                            FirebaseAuthStruct.isUserSignedIn()
                            // end testing
                            self.checkmarkIcon.tintColor = .green
                            DB.getUser(withPhone: String(self.phoneNumber)){
                                userDB in
                                
                                if let user = userDB {
                                    /*
                                     Saving the user in the local DB
                                     */
                                    RealmManager.shared.create(user)
                                    /*
                                     Saving the user state of being signed in
                                     */
                                    
                                    // styling
                                    self.navigationController?.navigationBar.isHidden = true
                                    self.navigationItem.hidesBackButton = true
                                    /*
                                     forwarding the user to the app shopping screen without
                                     asking for name, since they did that in the past
                                     */
                                    self.performSegue(withIdentifier: K.segues.loginProcess.toTabScreensWithoutRegistration, sender: self)
                                }else{
                                    /*
                                     TODO:need to write the user to the DB
                                     */
                                    
                                    /*
                                     forwarding the user to the screen asking them for
                                     user names since they are new users
                                     */
                                    FirebaseAuthStruct.user = User()
                                    FirebaseAuthStruct.user.mobileNumber = self.phoneNumber
                                    FirebaseAuthStruct.user.ID = FirebaseAuthStruct.auth.currentUser!.uid
                                    
                                    
                                    self.performSegue(withIdentifier: K.segues.loginProcess.registerNewUser, sender: self)
                                }
                            }
                        }else{
                            self.okAlert( "Incorrect Code" ,"Please make sure you enter the correct verfication code", nil)
                        }
                    }
                }
            }else{
                okAlert("Code Needed", "Please enter the verfication code", nil)
            }
        }
    }
    
    @IBAction func resendPressed(_ sender: Any) {
        if numberOfTimesResendPressed < maxNumberOfResending {
            // style
            resendButton.isHidden = true
            countDownTimeCurrent = countDownTime
            verifyTextFeild.text = ""
            upperMessageLabel.text = "Please type the verification code sent to \(phoneNumber)"
            // sms
            sendVerificationCode(forPhone: self.phoneNumber)
            decreaseTimer()
            numberOfTimesResendPressed += 1
        }else{
            okAlert( "Max SMS Requests Reached",  "You have reached the maximum number of SMS requests, check your network connectivity, and try again in few minutes", nil)
            
            
            print("Invalid press")
        }
    }
    
    func sendVerificationCode(forPhone phone:String){
        FirebaseAuthStruct.sendVerficationMessage(forPhone: phone){
            verificationID in
            self.messageSendingRequested = true
            self.verificationID = verificationID
        }
    }
    func verifyCode(verificationCode:String, verificationID:String , completion: @escaping (_ isSuccessful:Bool)->()){
        //FIXME: isMFAendabled is fixed to true. It is not know what it does
        FirebaseAuthStruct.verifyCode(verificationID: verificationID, verificationCode: verificationCode, isMFAEnabled: true){
            isSuccessful in
            
            completion(isSuccessful)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        verifyTextFeild.becomeFirstResponder()
        upperMessageLabel.text = "Please type the verification code sent to \(phoneNumber)"
    }
    
    func decreaseTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if countDownTimeCurrent >= 0 {
            timeLabel.text = "Did not receive SMS in \(countDownTimeCurrent)s?"
            countDownTimeCurrent -= 1
        }else{
            timer.invalidate()
            timeLabel.text = "Did you receive the SMS?"
            resendButton.isHidden = false
        }
    }
    
    func styleUI (){
        view.backgroundColor = UIColor(rgb: Colors.darkBlue)
        verifyTextFeild.backgroundColor = UIColor(rgb: Colors.mediumBlue)
        timeLabel.textColor = .white
        verifyButton.layer.cornerRadius = 10
    }
}



extension VerifyViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField.text != nil{
            // range: is the highlighted text that is to be replace by user input
            // string: is the new character or the pasted text
            
            
            let maxVerficationDigits = 12
            //let maxInputCount = 2 * maxVerficationDigits - 1 // for spaces
            let maxInputCount = maxVerficationDigits
            let currentInputCount = textField.text!.count + string.count - range.length
            
            let maxIsNotReached:Bool = currentInputCount <= maxInputCount
            
            if maxIsNotReached {
                return true
            }else{
                return false
            }
            
        }else{
            return true
        }
        
    }
    
    
    
}



