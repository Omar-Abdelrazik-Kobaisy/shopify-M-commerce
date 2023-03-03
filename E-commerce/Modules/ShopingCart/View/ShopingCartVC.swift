//
//  ShopingCartVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 01/03/2023.
//

import UIKit

class ShopingCartVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var totalItemsPriceLabel: UILabel!
    
    
    var addedPricetoInitialPOI : Int = 0
    var initialTotalpriceOfItems : Int = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for: indexPath) as! ShopingCartTableViewCell
        cell.itemImage.image = UIImage(named: "H")
        cell.itemName.text = "item Name ex"
        if cell.ItemCount.text == "1" {
            cell.itemPrice.text = "120"
        }else{
            cell.itemPrice.text = String(120 * cell.itemCountInt)
        }
        initialTotalpriceOfItems += Int(cell.itemPrice.text!) ?? 0
        totalItemsPriceLabel.text = String(initialTotalpriceOfItems)
  
        return cell
    }
    //********************************
    func updateTotalPrice(addedPrice : Int){
        var newTotalPrice = initialTotalpriceOfItems + addedPrice
        self.totalItemsPriceLabel?.text = String(newTotalPrice)
       
    }
    //********************************
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func proceed(_ sender: Any) {
       // tableViewOutlet.reloadData()
       totalItemsPriceLabel.text = "000"

    }
    

}
