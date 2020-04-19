//
//  SwiftExtentions.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/17/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit

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

extension UIViewController {

    func okAlert( _ title: String, _ message : String,_ completionFunc: (()->())?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        //print("You've pressed OK Button")
        if let completionFunc = completionFunc {
            completionFunc()
        }
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
