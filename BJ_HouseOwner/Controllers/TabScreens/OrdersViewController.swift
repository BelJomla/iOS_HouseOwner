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
    var content = [["rice","foon","mark"],["rice1","foon1","mark1"],["rice2","foon2","mark2"]]
    
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
            return content[tableView.tag-innerTableStartingMarginForTag].count
        }else {
            assert(tableView.tag == outTebleTag, tagError)
            return content.count
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
    func cancelClicked(tag: Int) {
        print("hello cancel")
        print("tag is \(tag)")
        content.remove(at: tag)
        //FIXME: -Deleting mulitple rows couse errors since the tag is same and array indecies change. Can use flag in array to indicate deletion instead
        let indexPath = IndexPath(row: tag, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func editClicked(tag: Int) {
        print("hello edit")
    }
    

}

