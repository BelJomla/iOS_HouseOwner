//
//  Category.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/15/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


struct ShoppingCategroy{
    /*
     categoryData: a 2d array that contains the categories
     and their sub-categoris. an example
     is like this: [['School','pencils','eraser'],
     ['Food','meat','chicken']]
     */
    var categoryData: [[String]]
    
    /*
     mainCategories: an array of the categoreies, an example is
     like this ['School','Food']
     */
    var mainCategories: [String]
    /*
     subCategoryData: is 2d array that is similar to categoryData
     , but it contains only the data that is being
     displayed on the screen. It is updated in the
     code as the user clicks different category.
     an example:[['School','pencils','eraser']]
     
     */
    var subCategoryData: [String]
    
    // category coloring handling
    var chosenCategoryIndex:Int
    var chosenSubcategoryIndex:Int
        

    
    init() {
        
        
        let (categoryData,mainCategories) =  ShoppingCategroy.readCategoreisData()
        self.categoryData = categoryData ?? [["no data"]]
        self.mainCategories = mainCategories ?? ["no categoreis"]
        self.subCategoryData = categoryData?[0] ?? ["no sub categories"] // first list of subcategories
        
        self.chosenCategoryIndex = 0
        self.chosenSubcategoryIndex = 0
    }
    /**
     This method reads categories in category.geojson
     Returns: a dictionary
     */
    static func readCategoreisData() -> ([[String]]?,[String]?) {
        
        guard let decoded = JsonReader.readLocalJson(fileName: "category", fileType: "geojson", classType: shoppingCategories.self) else{
            return (nil,nil)
        }
        
        let categoryCount = decoded.categories.count
        
        
        var categoryData :[[String]] = []
        var mainCategories :[String] = []
        
        for index in (0..<categoryCount) {
            let categoryName:String = decoded.categories[index].name
            let viewAll:String = "View All"
            
            let temp:[String] = [viewAll]//[categoryName,viewAll]
            let subCategories:[String] = decoded.categories[index].subCategories
            
            // building up the catgories array
            mainCategories.append(categoryName)
            // contactinating the two arrays
            categoryData.append(temp + subCategories)
        }
        
        return (categoryData,mainCategories)
        
        
    }
    
    func getCategoryData()->[[String]]{
        return self.categoryData
    }
    func getMainCategories()->[String]{
        return self.mainCategories
    }
    func getSubCategoryData()->[String]{
        return self.subCategoryData
    }
    func getChosenCategoryIndex () -> Int{
        return self.chosenCategoryIndex
    }
    func getChosenSubcategoryIdex() -> Int{
        return chosenSubcategoryIndex
    }
    
    
}
