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
import SDWebImage

class ShoppingViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    /*
     categoryData: a 2d array that contains the categories
     and their sub-categoris. an example
     is like this: [['School','pencils','erasers'],
     ['Food','meat','chicken']]
     */
    var categoryData: [[Any]] = []
    /*
     mainCategories: an array of the categoreies, an example is
     like this ['School','Food']
     */
    var mainCategories: [ShoppingCategory] = []
    /*
     displayedSubCategoryData: is 2d array that is similar to categoryData
     , but it contains only the data that is being
     displayed on the screen. It is updated in the
     code as the user clicks different category.
     an example:[['School','pencils','eraser']]
     */
    var displayedSubCategoryData: [ShoppingSubCategory] = []
    
    var displayedSubCategoryProducts: [Product] = []
    
    var wantedProducts : [Product] = []
    
    var remainingProductsToDisplay = 0
    
    var preferredLanguage = "en"
    
    var noProductsAvailble = true // in a clicked subcategory
    
    var chosenCategoryIndex:Int = 0
    var chosenSubcategoryIndex:Int = 0
    var aCategoryIsSelected = false
    
    var selectedCategory:ShoppingCategory? = nil
    var isFirstTimeLoadingRenderingTableView:Bool = true
    
    let firstSection = ShoppingTableView.firstSectionIndex
    let secondSection = ShoppingTableView.secondSectionIndex
    let thirdSection = ShoppingTableView.thirdSectionIndex
    
    override func viewDidLoad() {
        styleUI()
        initCategories()
        prepareTableView()
    }
    
    func prepareTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: K.UITableCells.nibNames.shoppingTableCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.UITableCells.IDs.shoppingTableCell)
    }
    
    @objc func rightBarButtonClicked(){
        Logger.log(.success, "Clicked right button item")
    }
    
    func styleUI(){
        
        let stylingModel = ShoppingStyling()
        self.tabBarController?.navigationItem.hidesBackButton = true
        stylingModel.styleNavigationBar(self.navigationItem, self.tabBarController, self.navigationController)
        stylingModel.styleTableView(tableView: self.tableView)
        
        let cartIcon = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        self.navigationItem.rightBarButtonItem  = cartIcon
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.white
        }
    }
    
    func initCategories(){
        DB.getCategories(){
            categories in
            
            for i in 0..<categories.count{
                if(!categories[i].hidden){
                    let category = categories[i]
                    self.mainCategories.append(category)
                    
                    var catWithSubCat:[Any] = []
                    catWithSubCat.append(category)
                    
                    for subCat in categories[i].subCategories{
                        catWithSubCat.append(subCat)
                    }
                    self.categoryData.append(catWithSubCat)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
}

//MARK: -TableView methods

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShoppingTableView.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==firstSection)
        {
            return 1
        }else if section==secondSection {
            //return 1 // in case error
            if(aCategoryIsSelected){
                return 1
            }else{
                return 0
            }
        }
        else{
            var count = Double(displayedSubCategoryProducts.count)/2.0
            count = count.rounded(.up)
            return Int(count)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(17)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        /*
         getting the appropriate header for each section
         */
        let label = ShoppingTableView.getSectionHeader(forSection: section)
        label.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        if section  == secondSection || section == thirdSection {
            if aCategoryIsSelected {
                return label
            }else{
                return nil
            }
        }else{
            return label
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0 || indexPath.section == 1){
            let categoryCellHeight = ShoppingTableView.cellWidth
            //Logger.log(.info, "categoryCellHeight= \(categoryCellHeight)")
            return categoryCellHeight//CGFloat(95)
            
        }else{
            //let productCellHeight = ShoppingTableView.cellHeight
            
            return CGFloat(310)////CGFloat(255)//productCellHeight//CGFloat(210)
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

        }else{

            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 2 + indexPath.row)
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
            if noProductsAvailble{
                return 1
            }else{
                if self.remainingProductsToDisplay >= 2 {
                    self.remainingProductsToDisplay -= 2
                    return 2
                } else{
                    if self.remainingProductsToDisplay == 1 {
                        self.remainingProductsToDisplay -= 1
     
                        return 1
                    }else{
                        return 2//0 This needs an exaplination FIXME: explain
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag==firstSection || collectionView.tag==secondSection{
            
            return CGSize(width: ShoppingCollectionView.categoryCellWidth, height: ShoppingCollectionView.cetegoryCellHeight)
            //return CGSize(width: CGFloat(60), height: CGFloat(60))
        }else{
            //FixMe: -Dont Access the screen width every time! just store it.
            //            return CGSize(width: ShoppingCollectionView.productCellWidth, height: ShoppingCollectionView.productCellHeight)
            return CGSize(width: CGFloat(170), height: CGFloat(260)) // 240h
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
            
            cell.label.text = mainCategories[indexPath.item].name[preferredLanguage]
            
            if cell.label.text == "All" {
                if isFirstTimeLoadingRenderingTableView {
                    isFirstTimeLoadingRenderingTableView = false
                    selectedCategory = mainCategories[indexPath.item]
                }
            }
            
            return cell
            
        }
        else if collectionView.tag == 1 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
            
            if(indexPath.row == chosenSubcategoryIndex){
                cell.backgroundColor = UIColor(rgb: Colors.mediumBlue)
            }else{
                cell.backgroundColor = .white
            }
            cell.label.text = displayedSubCategoryData[indexPath.item].name[preferredLanguage]
            return cell
        
        }else{
            print("FICK")
            let cell:UICollectionViewCell
            Logger.log(.success, "EE Empty Cell value \(noProductsAvailble)")
            if noProductsAvailble {
                cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.UICollectionCells.IDs.noProductCell, for: indexPath) as! NoProductCollectionViewCell
                Logger.log(.success, "EE Empty Cell Enterd")
            }else{
                
                let index = getIndexOfProduct(withTag: collectionView.tag, andRow: indexPath.row)
                let product = displayedSubCategoryProducts[index]
                let mycell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingProductCell, for: indexPath) as! ProductCollectionViewCell
                
                mycell.minusButtonActionBlock = {
                    var currentQuatity = Int(mycell.quatityLabel.text!)
                    if(currentQuatity != 0){
                        currentQuatity! -= 1
                    }
                    mycell.quatityLabel.text = String(currentQuatity!)
                    RealmManager.shared.update(product.self, with: ["wantedQuantity":currentQuatity])
                    self.wantedProducts = self.updateProdcutInCart(product, self.wantedProducts)
                    
                }
                mycell.plusButtonActionBlock = {
                    var currentQuatity = Int(mycell.quatityLabel.text!)
                    
                    currentQuatity! += 1
                    mycell.quatityLabel.text = String(currentQuatity!)
                    
                    self.wantedProducts = self.updateProdcutInCart(product, self.wantedProducts)
                    
                }
                
                mycell.price.text = "SR \(product.sellingPrice)"
                
                var productName = ""
                for name in product.name {
                    if name.key == preferredLanguage
                    {
                        productName = name.value
                    }
                }
                mycell.title.text = productName//product.name[0].value
                
                let url = URL(string: product.imageURLs[0])
                mycell.image.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
                cell = mycell
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path row \(indexPath.row)")
        
        
        if (collectionView.tag == firstSection ){
            //displayedSubCategoryProducts = []
            remainingProductsToDisplay = 0//displayedSubCategoryProducts.count//displayedSubCategoryData.count
            selectedCategory = mainCategories[indexPath.item]
            //selectedCategory?.toString()
            
            if (!aCategoryIsSelected){
                // will run once
                aCategoryIsSelected = true
                tableView.reloadData()
            }
            
            updateTableView(for: indexPath)
            chosenCategoryIndex = indexPath.row
            
            if (selectedCategory?.name["en"] == "All"){
                displayedSubCategoryProducts = []
                DB.getAllProducts(){
                    products in
                    
                    self.displayedSubCategoryProducts = []
                    
                    if products.isEmpty{
                        self.noProductsAvailble = true
                        self.displayedSubCategoryProducts = []
                    }else{
                        for product in products {
                            
                            self.displayedSubCategoryProducts.append(product)
                        }
                        self.noProductsAvailble = false
                        self.remainingProductsToDisplay = self.displayedSubCategoryProducts.count
                    }
                    // this is to reload the third section of the tableView
                    self.tableView.reloadData()
                    
                }
                
            }
            //chosenSubcategoryIndex = 0
            //collectionView.reloadData()
            tableView.reloadData()
            
            
        } else if ( collectionView.tag == secondSection){
            
            displayedSubCategoryProducts = []
            remainingProductsToDisplay = 0//displayedSubCategoryData.count
            
            let subCatName = String(displayedSubCategoryData[indexPath.row].name["en"]!)
            
            //Logger.log(.success, " ENTERD 420  remainingProductsToDisplay : \(remainingProductsToDisplay)")
            
            if subCatName == "All"{
                
                chosenSubcategoryIndex = indexPath.row
                self.tableView.reloadData()
                
                let catID = selectedCategory!.ID
                
                // background activity
                DB.getProducts(withCollectionID: catID){
                    products in
                    
                    self.displayedSubCategoryProducts = []
                    
                    if products.isEmpty{
                        self.noProductsAvailble = true
                        self.displayedSubCategoryProducts = []
                    }else{
                        for product in products {
                            
                            self.displayedSubCategoryProducts.append(product)
                        }
                        self.noProductsAvailble = false
                        self.remainingProductsToDisplay = self.displayedSubCategoryProducts.count
                    }
                    // this is to reload the third section of the tableView
                    self.tableView.reloadData()
                }
            }else{
                chosenSubcategoryIndex = indexPath.row
                
                let subCatID = displayedSubCategoryData[indexPath.row].ID
                self.tableView.reloadData()
                
                // background activity
                DB.getProducts(withSubCollectionID: subCatID){
                    products in
                    
                    self.displayedSubCategoryProducts = []
                    
                    for product in products {
                        self.displayedSubCategoryProducts.append(product)
                    }
                    
                    if products.isEmpty{
                        self.noProductsAvailble = true
                        self.remainingProductsToDisplay = 0//self.displayedSubCategoryProducts.count
                    }else{
                        self.noProductsAvailble = false
                        self.remainingProductsToDisplay = self.displayedSubCategoryProducts.count
                        
                    }
                    // this is to reload the third section of the tableView
                    self.tableView.reloadData()
                }
            }
            tableView.reloadData()
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
         since subCategoryData is a 2D, the .count will FIXME:return 2
         and it is the row number the should be deleted
         */
        
        let indexToDelete = 0//FIXEME:subCategoryData.count-1
        // creating an instance of IndexPath, sinindexToDeletece it is needed for deleteSubCategoryRow
        let indexPathToDelete = IndexPath(row:indexToDelete, section: 1)
        // removing the subcatogy values from the array before updating the UITableView
        
        //self.subCategoryData.remove(at: indexToDelete)
        self.displayedSubCategoryData = [] // deleting all elements
        // adding the new subcategory
        //self.subCategoryData.append(categoryData[indexPath.row])
        //        for singleSubCategory in categoryData[indexPath.row]{
        //            self.displayedSubCategoryData.append(singleSubCategory)
        //        }
        for i in 1..<categoryData[indexPath.row].count{
            self.displayedSubCategoryData.append(categoryData[indexPath.row][i] as! ShoppingSubCategory)
        }
        // the actual addition, deletion and update of the uitableivew
        replaceSubCategoryRow(delete: indexPathToDelete, section: 1)
    }
    
}

//MARK: -CollectionView Helpers

extension ShoppingViewController {
    
    func getIndexOfProduct(withTag tag:Int,andRow row:Int )->Int{
        return 2*(tag - 2) + row
    }
    
    func updateProdcutInCart(_ product:Product,_ cart:[Product]) -> [Product]{
        var myCart = cart
        var isFound = false
        for i in 0..<myCart.count{
            if cart[i].ID == product.ID{
                isFound = true
                myCart.remove(at: i)
                if cart[i].wantedQuantity > 0{
                    myCart.append(product)
                }
            }
        }
        if !isFound{
            myCart.append(product)
        }
        return myCart
    }
    
}
