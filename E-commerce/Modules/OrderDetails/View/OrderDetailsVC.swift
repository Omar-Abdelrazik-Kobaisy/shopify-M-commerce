//
//  OrderDetailsVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit

class OrderDetailsVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var OrderDateLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    
    var created_at : String?
    var user_name : String?
    var arr_of_orders : [OrderItem]!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_of_orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetialsTableViewCell", for: indexPath) as! OrderDetialsTableViewCell
        
               cell.ItemDescriptionTextView.text = arr_of_orders[indexPath.row].name
               cell.PriceValueLabel.text = arr_of_orders[indexPath.row].price
               cell.QuantityValueLabel.text = String(arr_of_orders[indexPath.row].quantity ?? 0)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        OrderDateLabel.text = created_at
        UserNameLabel.text = user_name
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
