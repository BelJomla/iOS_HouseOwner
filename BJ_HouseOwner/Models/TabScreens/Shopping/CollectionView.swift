//
//  CollectionView.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/15/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class ShoppingCollectionView{
    /*
     Collection cell height and width with respect to the screen dimentions. Note: it does not work very well on the ipad
     */

    static let categoryCellWidth = UIScreen.main.bounds.width/6.9
    static let cetegoryCellHeight = categoryCellWidth
    
    static let productCellWidth = UIScreen.main.bounds.width/2.3
    static let productCellHeight = UIScreen.main.bounds.height/4.5
    static let categotyMinimumLineSpacing = CGFloat(10)
    static let productMinimumLineSpacing = CGFloat(12)
    
    init() {
        
    }
}
