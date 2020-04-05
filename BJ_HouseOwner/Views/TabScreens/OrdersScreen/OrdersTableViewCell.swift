//
//  OrdersTableViewCell.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/21/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainView: UIView!
    
    var myDeligate:OrderCellDeligate? = nil
    var innerTableStartingMarginForTag = 10000
    override func awakeFromNib() {
        super.awakeFromNib()

        let nib = UINib(nibName:K.UI.ordersInnerCellNibName , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.UI.ordersInnerCellID)
        
        

        self.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        editButton.layer.cornerRadius  = 10
        bottomView.backgroundColor = UIColor(rgb: 0xF6F6F6)
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 2
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        
        myDeligate?.cancelClicked(tag: self.tag)
    }
    @IBAction func editClicked(_ sender: Any) {
        myDeligate?.editClicked(tag: self.tag)
    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
//    

    func setInnerTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate & OrderCellDeligate, forRow row: Int) {
        self.myDeligate = (dataSourceDelegate as OrderCellDeligate)
        
        tableView.delegate = dataSourceDelegate
        tableView.dataSource = dataSourceDelegate
        tableView.tag = row + innerTableStartingMarginForTag
        tableView.reloadData()
    }
    
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20))
//    }
//    
}
