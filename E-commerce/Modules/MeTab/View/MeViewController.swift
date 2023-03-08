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
    
    var orders : GetOrder?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.integer(forKey:"loginid"))
               
               let url = "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(UserDefaults.standard.integer(forKey:"loginid"))/orders.json"
               
               ApiService.fetchFromApi(API_URL: url) { [weak self] data in
                   self?.orders = data

                   DispatchQueue.main.async {
                       self?.Order_TableV.reloadData()
                   }
               }


    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Order_TableV
        {
            return orders?.orders.count ?? 0
        }
        return 19
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Order_TableV
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderTableViewCell
            
            cell.order_price.text = orders?.orders[indexPath.row].current_total_price
            cell.order_createdat.text = orders?.orders[indexPath.row].created_at
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
                
                orderDetailsVC.created_at = orders?.orders[indexPath.row].created_at
                orderDetailsVC.user_name = (orders?.orders[indexPath.row].customer.first_name ?? "") + " " + (orders?.orders[indexPath.row].customer.last_name ?? "")
                
                orderDetailsVC.arr_of_orders = orders?.orders[indexPath.row].line_items
                
                
                self.navigationController?.pushViewController(orderDetailsVC, animated: true)

    }

    

}
