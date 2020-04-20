//
//  ShoppingViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/19/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


class ShoppingViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    /*
     categoryData: a 2d array that contains the categories
     and their sub-categoris. an example
     is like this: [['School','pencils','erasers'],
     ['Food','meat','chicken']]
     */
    var categoryData: [[String]] = []
    /*
     mainCategories: an array of the categoreies, an example is
     like this ['School','Food']
     */
    var mainCategories: [String] = []
    /*
     displayedSubCategoryData: is 2d array that is similar to categoryData
     , but it contains only the data that is being
     displayed on the screen. It is updated in the
     code as the user clicks different category.
     an example:[['School','pencils','eraser']]
     */
    var displayedSubCategoryData: [String] = []
    
    var chosenCategoryIndex:Int = 0
    var chosenSubcategoryIndex:Int = 0
    
    let firstSection = ShoppingTableView.firstSectionIndex
    let secondSection = ShoppingTableView.secondSectionIndex
    let thirdSection = ShoppingTableView.thirdSectionIndex
    
    override func viewDidLoad() {
        print("shopping")
        styleUI()
        // intialization of category arrays
        initCategories()
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.white
        }
        
        // plugging in data source and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // registering the custom cell
        let nib = UINib(nibName: "shoppingTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.shoppingTableCell)
    }
    
    @objc func rightBarButtonClicked(){
        Logger.log(.success, "Clicked right button item")
    }
    
    func styleUI(){
        let stylingModel = ShoppingStyling()
        stylingModel.styleNavigationBar(self.navigationItem, self.tabBarController, self.navigationController)
        stylingModel.styleTableView(tableView: self.tableView)
        
        let cartIcon = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        self.navigationItem.rightBarButtonItem  = cartIcon
    }
    
    func initCategories(){
        DB.getCategories(){
            categories in
            
            
            for i in 0..<categories.count{
                if(!categories[i].hidden){
                    let categoryName = categories[i].name["en"]!
                    self.mainCategories.append(categoryName)
                    
                    var catWithSubCat:[String] = []
                    catWithSubCat.append(categoryName)
                    
                    for subCat in categories[i].subCategories{
                        catWithSubCat.append(subCat.name["en"]!)
                    }
                    self.categoryData.append(catWithSubCat)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hides the backbutton on the navigation bar, since the user
        // should not go back the verificaiton screen
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
}

//MARK: -TableView methods

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShoppingTableView.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==firstSection || section==secondSection)
        { return 1}
        else{
            return ShoppingTableView.numberOfProducts
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*
         getting the appropriate header for each section
         */
        let label = ShoppingTableView.getSectionHeader(forSection: section)
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0 || indexPath.section == 1){
            let categoryCellHeight = ShoppingTableView.cellWidth
            return categoryCellHeight//CGFloat(95)
            
        }else{
            let productCellHeight = ShoppingTableView.cellHeight
            
            return productCellHeight//CGFloat(210)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.shoppingTableCell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? shoppingTableCell else {return}
        
        if (indexPath.section==1 || indexPath.section==0){
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section /*indexPath.item*/)
            
            print("\(indexPath.section)\(indexPath.item)")
        }else{
            
            //            let collectionViewLayout = tableViewCell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            //
            ////            collectionViewLayout?.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            //
            //            collectionViewLayout?.invalidateLayout()
            //            tableViewCell.collectionView.collectionViewLayout =
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 2 + indexPath.item)
            
            print("\(indexPath.section)\(indexPath.item)")
        }
    }
}

//MARK: -CollectionView methods
extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == firstSection {
            return mainCategories.count
        }else if collectionView.tag == secondSection {
            return displayedSubCategoryData.count
        }else{
            return ShoppingTableView.numOfProductsInRow
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag==firstSection || collectionView.tag==secondSection{
            
            return CGSize(width: ShoppingCollectionView.categoryCellWidth, height: ShoppingCollectionView.cetegoryCellHeight)
            //return CGSize(width: CGFloat(60), height: CGFloat(60))
        }else{
            //FixMe: -Dont Access the screen width every time! just store it.
            return CGSize(width: ShoppingCollectionView.productCellWidth, height: ShoppingCollectionView.productCellHeight)
            //return CGSize(width: CGFloat(180), height: CGFloat(200))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag==0 || collectionView.tag==1{
            return ShoppingCollectionView.categotyMinimumLineSpacing
        }else{
            return ShoppingCollectionView.productMinimumLineSpacing
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
            
            if(indexPath.row == chosenCategoryIndex){
                cell.backgroundColor = UIColor(rgb: Colors.mediumBlue)
            }else{
                cell.backgroundColor = .white
            }
            
            cell.label.text = mainCategories[indexPath.item]
            return cell
        }else if collectionView.tag == 1 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
            
            if(indexPath.row == chosenSubcategoryIndex){
                cell.backgroundColor = UIColor(rgb: Colors.mediumBlue)
            }else{
                cell.backgroundColor = .white
            }
            cell.label.text = displayedSubCategoryData[indexPath.item]
            return cell
        }else{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingProductCell, for: indexPath) as! ProductCollectionViewCell
            return cell
        }
        //cell.label.text = subCategoryData[collectionView.tag][indexPath.item]
        //categoryData[collectionView.tag][indexPath.item]//subCategoryData[collectionView.tag][indexPath.item]//categoryData[collectionView.tag][indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        if (collectionView.tag == firstSection ){
            updateTableView(for: indexPath)
            chosenCategoryIndex = indexPath.row
            //chosenSubcategoryIndex = 0
            collectionView.reloadData()
            
        } else if ( collectionView.tag == secondSection){
            chosenSubcategoryIndex = indexPath.row
            collectionView.reloadData()
        }else{
            
        }
    }
}

//MARK: -TableView Update Helpers
extension ShoppingViewController {
    
    func replaceSubCategoryRow(delete indexPath:IndexPath, section:Int){
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        
        let indexPathToAdd = IndexPath(row:0, section: section)
        chosenSubcategoryIndex = 0
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
        self.displayedSubCategoryData = [] // deleting all elements
        // adding the new subcategory
        //self.subCategoryData.append(categoryData[indexPath.row])
        for singleSubCategory in categoryData[indexPath.row]{
            self.displayedSubCategoryData.append(singleSubCategory)
        }
        // the actual addition, deletion and update of the uitableivew
        replaceSubCategoryRow(delete: indexPathToDelete, section: 1)
    }
}
