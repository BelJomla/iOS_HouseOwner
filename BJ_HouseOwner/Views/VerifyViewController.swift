//
//  VerifyViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/18/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit
class VerifyViewController: UIViewController{
    
    
    
    @IBOutlet weak var verifyTextFeild: UITextField!
    override func viewDidLoad() {
        verifyTextFeild.delegate = self
        styleUI()
    }
    
    
    
    
    func styleUI (){
        view.backgroundColor = UIColor(rgb: Colors.darkBlue)
        verifyTextFeild.backgroundColor = UIColor(rgb: Colors.mediumBlue)
    }
}

extension VerifyViewController:UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        let newLength = text.count + string.count - range.length
//        return newLength <= 7
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField.text != nil{
            // range: is the highlighted text that is to be replace by user input
            // string: is the new character or the pasted text
            
            
            
            let maxVerficationDigits = 6
            let maxInputCount = 2 * maxVerficationDigits - 1 // for spaces
            let currentInputCount = textField.text!.count + string.count - range.length

            
            return currentInputCount <= maxInputCount
            
        }else{
            return true
        }
        
    }
    
    /// this method adds a space between each two characters
    ///  It is used to make the text field look more buetiful
    /// - Parameter text: the text to be butified
    /// - Output String: the butified string
    func addSpaces (_ text:String)-> String{
        if text == "" { return "" }
        
        var trimmedString = ""
        var outputString = ""
        
        // removing all spaces
        for char in text{
            if (String(char) != " " && text.count >= 1){
                trimmedString += String(char)
            }
        }

        // adding the spaces
        for char in trimmedString{
            outputString += String(char) + " "
        }
        
        // removing the last extra space
        outputString = outputString.substring(to: outputString.count - 1)
        
        return outputString
    }
    
    @IBAction func fieldChanged(_ sender: UITextField) {
        if let safeText = sender.text {
            sender.text = addSpaces(safeText)
        }
        
    }
    
    
    
}

//MARK: -Swift extenstions
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
