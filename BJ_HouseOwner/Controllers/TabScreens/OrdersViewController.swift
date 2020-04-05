//
//  OrdersViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/3/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    let outTebleTag = 0
    let innerTableStartingMarginForTag = 10000
    
    let tagError:String = "_ERROR: Received an expected tableView tag"
    let content = [["Mann Filter For Heros - - - -"],["بطاطس حجم كبير جدا 232"],["3q234123"],["Mann Filter For Heros - - - -"],["Mann Filter For Heros - - - -"],["بطاطس حجم كبير جدا 232"],["3q234123"],["Mann Filter For Heros - - - -"]]
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: K.UI.ordersCellNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.UI.ordersCellID)
        
    }
    
    
    
    
}

//MARK: -UITableView

extension OrdersViewController: UITableViewDelegate,UITableViewDataSource{
    
    

    
    
        
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if tableView.tag > outTebleTag{
            // nothing needed
            print("willDisplayInnerCell")
        }else {
            assert(tableView.tag == outTebleTag, tagError)
            
            guard let tableViewCell = cell as? OrdersTableViewCell else { return }
            tableViewCell.setInnerTableViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            cell.tag = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag > outTebleTag{
            return CGFloat(38)
        }else {
            assert(tableView.tag == outTebleTag, tagError)
            assert(indexPath.row < innerTableStartingMarginForTag, "Too many Orders, inner table tags and outer cell tags have similar numbers now")
            let extraHeightForInnerRows = CGFloat(content.count * 39)
            print("additional height")
            print(extraHeightForInnerRows)
            return CGFloat(200) + extraHeightForInnerRows
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag > outTebleTag{
            return content.count
        }else {
            assert(tableView.tag == outTebleTag, tagError)
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.tag > outTebleTag{
            return tableView.dequeueReusableCell(withIdentifier: K.UI.ordersInnerCellID, for: indexPath)
            
        }else {
            assert(tableView.tag == outTebleTag, tagError)
 
            return tableView.dequeueReusableCell(withIdentifier: K.UI.ordersCellID, for: indexPath)

        }
        
    }
    
    
}


//MARK: -InnerCellDelegatation

extension OrdersViewController: OrderCellDeligate{
    func cancelClicked() {
        print("hello cancel")
    }
    
    func editClicked() {
        print("hello edit")
    }
    

}

