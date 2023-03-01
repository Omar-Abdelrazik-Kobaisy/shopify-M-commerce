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

        // Do any additional setup after loading the view.
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

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
