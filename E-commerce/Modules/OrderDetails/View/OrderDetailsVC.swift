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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetialsTableViewCell", for: indexPath) as! OrderDetialsTableViewCell
        
        cell.ItemDescriptionTextView.text = "item discription"
        cell.PriceValueLabel.text = "5"
        cell.PriceValueLabel.text = "1200"
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        OrderDateLabel.text = "2-3-2023"
        UserNameLabel.text = "Mark"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
