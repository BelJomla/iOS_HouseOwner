//
//  shoppingTableCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/22/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class shoppingTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.layer.cornerRadius = 20
        //self.collectionView.layer.cornerRadius = 10
        //        self.layer.cornerRadius = 50
        //        self.collectionView.layer.cornerRadius = 30
        //        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        let productNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(productNib, forCellWithReuseIdentifier:K.shoppingProductCell)
        
        
        let categoryNib = UINib(nibName: "shoppingCollectionCell", bundle: nil)
        collectionView.register(categoryNib, forCellWithReuseIdentifier: K.shoppingCollectionCell)
        
        collectionView.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        // autoscroll fix is on author github
        collectionView.reloadData()
    }
    
}
