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
        verifyTextFeild.delegate = self
        resendButton.isHidden = true
        styleUI()
        sendVerificationCode(forPhone: "+966512345678")
//        sendVerificationCode(forPhone: self.phoneNumber)
        decreaseTimer()
    }
    @IBAction func verifyButtonPressed(_ sender: Any) {
        if(!messageSendingRequested){
            // message not requested yet from firebase
        }else{
            if let enteredCode = verifyTextFeild?.text {
                if enteredCode == "" {
                    okAlert(title: "Code Needed", message: "Please enter the verfication code")
                }else{
                    // some code entered (may not be correct)
                    //let verificationCode = "111222"
                    verifyCode(verificationCode: enteredCode , verificationID: self.verificationID){
                        isSuccessful in
                        
                        if isSuccessful{
                            self.performSegue(withIdentifier: K.registerNewUser, sender: self)
                        }else{
                            self.okAlert(title: "Incorrect Code", message: "Please make sure you enter the correct verfication code")
                        }
                    }
                }
            }else{
                okAlert(title: "Code Needed", message: "Please enter the verfication code")
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
            okAlert(title: "Max SMS Requests Reached", message: "You have reached the maximum number of SMS requests, check your network connectivity, and try again in few minutes")
            
            print("Invalid press")
        }
    }
    
    func okAlert(title:String, message:String){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendVerificationCode(forPhone phone:String){
        FirebaseAuth.sendVerficationMessage(forPhone: phone){
            verificationID in
            self.messageSendingRequested = true
            self.verificationID = verificationID
        }
    }
    func verifyCode(verificationCode:String, verificationID:String , completion: @escaping (_ isSuccessful:Bool)->()){
        //FIXME: isMFAendabled is fixed to true. It is not know what it does
        FirebaseAuth.verifyCode(verificationID: verificationID, verificationCode: verificationCode, isMFAEnabled: true){
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

