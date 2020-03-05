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
     subCategoryData: is 2d array that is similar to categoryData
     , but it contains only the data that is being
     displayed on the screen. It is updated in the
     code as the user clicks different category.
     an example:[['School','pencils','eraser']]
     
     */
    var subCategoryData: [String] = []
    
 
    
    override func viewDidLoad() {
        print("shopping")
        
        styleNavigationBar()
        
        // testing
        let (categoryData,mainCategories) =  readCategoreisData()
        self.categoryData = categoryData ?? [["no data"]]
        self.mainCategories = mainCategories ?? ["no categoreis"]
        self.subCategoryData = categoryData?[0] ?? ["no sub categories"] // first list of subcategories

        
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

        return (categoryData,mainCategories)
        
        
    }
    
}

//MARK: -TableView methods

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==1 || section==0){ return 1}
        return 30 // third section of items//return subCategoryData.count // one row // mainCategories
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "category"
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //30
        let cell = tableView.dequeueReusableCell(withIdentifier: K.shoppingTableCell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? shoppingTableCell else {return}
        
       
        print("\(indexPath.section)\(indexPath.item)")
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section /*indexPath.item*/)
    }
    
}




//MARK: -CollectionView methods
extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return mainCategories.count
        }else if collectionView.tag == 1 {
            return subCategoryData.count
        }else{
            return 2 // two products for the third section per row
        }
        
        //return 3 //subCategoryData[collectionView.tag].count
            //categoryData[collectionView.tag].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
        
        //cell.backgroundColor = categoryDict[collectionView.tag][indexPath.item]
        if collectionView.tag == 0 {
            cell.label.text = mainCategories[indexPath.item]
        }else if collectionView.tag == 1 {
            cell.label.text = subCategoryData[indexPath.item]
        }
        //cell.label.text = subCategoryData[collectionView.tag][indexPath.item]
            //categoryData[collectionView.tag][indexPath.item]//subCategoryData[collectionView.tag][indexPath.item]//categoryData[collectionView.tag][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        updateTableView(for: indexPath)
    }
    
    
}

//MARK: -TableView Update Helpers
extension ShoppingViewController {

    func replaceSubCategoryRow(delete indexPath:IndexPath, section:Int){
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        
        let indexPathToAdd = IndexPath(row:0, section: section)
        
        tableView.insertRows(at: [indexPathToAdd], with: .left)
        tableView.endUpdates()
    }
    
    func updateTableView(for indexPath:IndexPath){
            

            /*
             since subCategoryData is a 2D, the .count will return 2
             and it is the row number the should be deleted
             */
            let indexToDelete = 0//subCategoryData.count-1
            // creating an instance of IndexPath, sinindexToDeletece it is needed for deleteSubCategoryRow
            let indexPathToDelete = IndexPath(row:indexToDelete, section: 1)
            // removing the subcatogy values from the array before updating the UITableView
        

            //self.subCategoryData.remove(at: indexToDelete)
            self.subCategoryData = [] // deleting all elements
            // adding the new subcategory
            //self.subCategoryData.append(categoryData[indexPath.row])
        for singleSubCategory in categoryData[indexPath.row]{
            self.subCategoryData.append(singleSubCategory)
        }
            // the actual addition, deletion and update of the uitableivew
            replaceSubCategoryRow(delete: indexPathToDelete, section: 1)

    }
}
