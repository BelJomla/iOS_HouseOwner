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
        let nib = UINib(nibName: "shoppingCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: K.shoppingCollectionCell)
        
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
