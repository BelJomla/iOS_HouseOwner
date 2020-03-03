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
    

    var categoryData: [[String]] = []
    var mainCategories: [String] = []
    var displayedData: [[String]] = []
    

    var subCategoryIsDisplayed:Bool = false
    
    override func viewDidLoad() {
        print("shopping")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    /**
            This method reads categories in category.geojson
                Returns: a dictionary
         
     */
    func readCategoreisData() -> ([[String]]?,[String]?) {
        // this instance is going to parse json
        let decoder = JSONDecoder()
        // this path is String? and is the easiest wasy to locate a file
        let path = Bundle.main.path(forResource: "category", ofType: "geojson")
        // this url object is required to genrate Data object
        let url = URL(fileURLWithPath: path!)
        
        do{
            // this data object is needed for JSONDecoder object
            let data = try Data(contentsOf: url)
            // this is the result of the decoded json
            let decoded = try decoder.decode(shoppingCategories.self, from: data )
            // this is the way it should be accessed -> decoded.category[0].name
           
            
            //FIXME: -This is hardcoded, find a better way
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
            
        }catch {
            print(" could not parse json \n")
            print(error)
            return (nil,nil)
        }
        
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
        
        if(!subCategoryIsDisplayed){
            subCategoryIsDisplayed = true
            
            self.displayedData.append(categoryData[indexPath.row])
            let newIndexPath = IndexPath(row:displayedData.count-1, section: 0)
            
            tableView.beginUpdates()
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.endUpdates()
        }else{
            subCategoryIsDisplayed = true
            
            let indexToDelete = displayedData.count-1
            
            let indexPathToDelete = IndexPath(row:displayedData.count-1, section: 0)
            self.displayedData.remove(at: indexToDelete)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPathToDelete], with: .fade)
            tableView.endUpdates()
            
            // repetative
            self.displayedData.append(categoryData[indexPath.row])
            let newIndexPath = IndexPath(row:displayedData.count-1, section: 0)
            
            tableView.beginUpdates()
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        
        
    }

    
}
   

