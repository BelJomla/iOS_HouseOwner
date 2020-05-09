//
//  TableView.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/15/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit

struct ShoppingTableView{
    /*
     we have three sections in the tableView, one for the categories, one for the subcategories and one for the products
     */
    static let numberOfSections = 3
    /*
     the number of products to be displayed, this is set constant for now, but it needs to have a logic to handle the infinite scrolling and the database connection
     */
    static let numberOfProducts = 0 // a dummy value
    /*
     These are the indecies that identify the category,subCategory and product sections.
     */
    static let firstSectionIndex = 0
    static let secondSectionIndex = 1
    static let thirdSectionIndex = 2
    
    /*
     The sections header strings. Note, we have added spaces before the string so that they look indented, this has to be changed using approperiate label margin properteis.
     */
    static let categoryHeader = "   Category"
    static let subCategoryHeader = "   Sub-Category"
    static let productHeader = "   Products"
    
    /*
     two products per row at the third section
     */
    static let numOfProductsInRow = 2
    
    
    /*
     Table cell height and width with respect to the screen dimentions. Note: it does not work very well on the ipad
     */
    static let cellWidth = CGFloat(UIScreen.main.bounds.height/9.5)
    static let cellHeight = CGFloat( UIScreen.main.bounds.width/1.5)
    
    init(){
        
    }
    
    /// This function returns a UILable which will be placed as a section header in the ShoppingScreen
    /// - Parameter section: the section of the tableView (i.e. category, subCategory or product)
    static func getSectionHeader(forSection section: Int) -> UIView{
        let label = UILabel()
        label.textColor = UIColor(rgb: Colors.darkBlue)
        
        if section == firstSectionIndex {
            label.text = categoryHeader
        }else if section == secondSectionIndex{
            label.text = subCategoryHeader
        }else{
            label.text = productHeader
        }
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }
    
}
