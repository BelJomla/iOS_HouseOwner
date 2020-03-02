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
    
//
//    let model : [[UIColor]] = [[UIColor.red, UIColor.blue,UIColor.black,UIColor.red, UIColor.blue,UIColor.black,UIColor.red, UIColor.blue,UIColor.black]
//
//        ,[UIColor.orange, UIColor.white,UIColor.yellow,UIColor.orange, UIColor.white,UIColor.yellow,UIColor.orange, UIColor.white,UIColor.yellow]]
    
    var model : [[String]] = [["Frozen", "Soap", "Plastics", "Food Buttles", "Kitchen Needs","Frozen", "Soap", "Plastics", "Food Buttles", "Kitchen Needs"], ["Sub1", "Sub2","Sub3","Sub1", "Sub2","Sub3","Sub1", "Sub2"]]
    
    override func viewDidLoad() {
        print("shopping")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "shoppingTableCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: K.shoppingTableCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
}

    //MARK: -TableView methods

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
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
        return model[collectionView.tag].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: K.shoppingCollectionCell, for: indexPath) as! shoppingCollectionCell
        
        //cell.backgroundColor = model[collectionView.tag][indexPath.item]
        cell.label.text = model[collectionView.tag][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        let newIndexPath = IndexPath(row:model.count-1, section: 0)
        self.model.append(["dynamic1","dynamic12","dynamic11"])

        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.endUpdates()
        
        
    }

    
}
   

