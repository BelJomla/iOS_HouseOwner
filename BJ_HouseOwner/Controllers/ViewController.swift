//
//  ViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/16/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    @IBOutlet weak var SignUpLabel: UILabel!
    
    @IBOutlet weak var NextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }
    
    
    /**
     This fuction updates the UI look and feel. Reason: hard to do using options
     */
    func styleUI(){
        SignUpLabel.textColor = UIColor(rgb: Colors.gray)
        NextButton.backgroundColor = UIColor(rgb: Colors.darkBlue)
        NextButton.layer.cornerRadius = K.cornerRadius
    }


}

//MARK: - UIColor Extenstion
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
