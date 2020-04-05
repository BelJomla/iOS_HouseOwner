//
//  ProfileViewController.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/2/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var balanceView: UIView!
    
    @IBOutlet weak var bottomLargeView: UIView!
    @IBOutlet weak var pointsView: UIView!
    
    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()

        // Do any additional setup after loading the view.
    }
    
    func styleUI(){
        balanceView.layer.cornerRadius = balanceView.layer.frame.width/2
        
        pointsView.layer.cornerRadius = pointsView.layer.frame.width/2
        
        bottomLargeView.layer.cornerRadius = 45
        
        bottomLargeView.backgroundColor = UIColor(rgb: Colors.smokeWhite)
        
        AddressView.layer.cornerRadius = 10
        historyView.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        
//        AddressView.layer.cornerRadius = 10
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
