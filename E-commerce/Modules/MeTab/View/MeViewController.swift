//
//  MeViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var Order_TableV: UITableView!
    
    
    @IBOutlet weak var Wish_TableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Order_TableV
        {
            return 5
        }
        return 19
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Order_TableV
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderTableViewCell
            
            cell.order_price.text = "9999$"
            cell.order_createdat.text = "3-3-2022"
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "wish", for: indexPath) as! WishTableViewCell
        
        cell.wish_image.image = UIImage(named: "M")
        cell.label_wish.text = "product_name"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    @IBAction func settingButton(_ sender: Any) {
        let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        navigationController?.pushViewController(setting, animated: true)
    }
    

    @IBAction func cartButton(_ sender: Any) {
        
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC") as! ShopingCartVC
        
        navigationController?.pushViewController(cart, animated: true)
    }

    

}
