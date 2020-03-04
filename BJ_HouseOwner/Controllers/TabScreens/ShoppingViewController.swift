//
//  ShoppingViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/19/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit


class ShoppingViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    
    /*
     categoryData: a 2d array that contains the categories
     and their sub-categoris. an example
     is like this: [['School','pencils','eraser'],
     ['Food','meat','chicken']]
     */
    var categoryData: [[String]] = []
    
    /*
     mainCategories: an array of the categoreies, an example is
     like this ['School','Food']
     */
    var mainCategories: [String] = []
    /*
     displayedData: is 2d array that is similar to categoryData
     , but it contains only the data that is being
     displayed on the screen. It is updated in the
     code as the user clicks different category.
     an example:[['School','pencils','eraser']]
     
     */
    var displayedData: [[String]] = []
    
    /*
     this flag indicates wheather the user has clicked
     a cetegory or not
     */
    var subCategoryIsDisplayed:Bool = false
    
    override func viewDidLoad() {
        print("shopping")
        
        styleNavigationBar()
        
        // testing
        let (categoryData,mainCategories) =  readCategoreisData()
        self.categoryData = categoryData ?? [["no data"]]
        self.mainCategories = mainCategories ?? ["no categoreis"]
        self.displayedData = [self.mainCategories]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "shoppingTableCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: K.shoppingTableCell)
        
    }
    
    func styleNavigationBar(){
        // changes the title of the nav bar
        navigationItem.title = "Shopping"
        // chages the background color to non transparent
        navigationController?.navigationBar.isTranslucent = false
        /*
         The following line hides the navigation bar propapigated from the tabBarController. If it was isHidden is assinged to false, it will appear again, but it will not look good.
         */
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hides the backbutton on the navigation bar, since the user
        // should not go back the verificaiton screen
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    
    
    
    /**
     This method reads categories in category.geojson
     Returns: a dictionary
     */
    func readCategoreisData() -> ([[String]]?,[String]?) {
        
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
        
        print(categoryData)
        print("--")
        print(mainCategories)
        
        return (categoryData,mainCategories)
        
        
    }
    
}

//MARK: -TableView methods

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count // one row // mainCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.shoppingTableCell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? shoppingTableCell else {return}
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.item)
    }
    
}




//MARK: -CollectionView methods
extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedData[collectionView.tag].count //categoryData[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
        
        //cell.backgroundColor = categoryDict[collectionView.tag][indexPath.item]
        cell.label.text = displayedData[collectionView.tag][indexPath.item]//categoryData[collectionView.tag][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        updateTableView(for: indexPath)
    }
    
    
}

//MARK: -TableView Update Helpers
extension ShoppingViewController {
    func insertSubCategoryRow(for indexPath:IndexPath){
        let newIndexPath = IndexPath(row:displayedData.count-1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    func deleteSubCategoryRow(for indexPath:IndexPath){
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    func updateTableView(for indexPath:IndexPath){
        if(!subCategoryIsDisplayed){
            // updating the flag, so that we go to the 'else' statement next time
            subCategoryIsDisplayed = true
            // adding the subcategory data to displayDate
            self.displayedData.append(categoryData[indexPath.row])
            // inserting the row and updating the table
            insertSubCategoryRow(for: indexPath)
        }else if (subCategoryIsDisplayed){
            /*
             since displayedData is a 2D, the .count will return 2
             and it is the row number the should be deleted
             */
            let indexToDelete = displayedData.count-1
            // creating an instance of IndexPath, since it is needed for deleteSubCategoryRow
            let indexPathToDelete = IndexPath(row:displayedData.count-1, section: 0)
            // removing the subcatogy values from the array before updating the UITableView
            self.displayedData.remove(at: indexToDelete)
            
            // removing the row and updating the table
            deleteSubCategoryRow(for: indexPathToDelete)
            /*
             now, we add the subCategory for the category that the user has clicked on
             */
            self.displayedData.append(categoryData[indexPath.row])
            //inserting the new row, and updating the table
            insertSubCategoryRow(for: indexPath)
            
        }
    }
}
