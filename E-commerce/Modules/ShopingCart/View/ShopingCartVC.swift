//
//  ShopingCartVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 01/03/2023.
//

import UIKit
import Kingfisher
class ShopingCartVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var totalItemsPriceLabel: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var models : [OrderListModel]?
    
    var orderViewModel : OrderViewModel?
    
    var orderProduct : [OrderItem] = []
    var order = Order.self
    var addedPricetoInitialPOI : Int = 0
    var initialTotalpriceOfItems : Int = 0
    
    
    
    override func viewDidLoad() {
        orderViewModel = OrderViewModel()
        orderViewModel?.bindingGet = { [weak self] in
            DispatchQueue.main.async {
                self!.models = self!.orderViewModel?.ObservableGet
                self?.tableViewOutlet.reloadData()
            }
            
            
        }
        orderViewModel?.getAllItems { cartItems, error in
            guard let items = cartItems else { return}
            self.models = items
            
        }
        checkCartIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for: indexPath) as! ShopingCartTableViewCell
        let url = URL(string: models![indexPath.row].itemImage!)
        cell.itemImage.kf.setImage(with: url)
        cell.itemName.text = models![indexPath.row].itemName
        if cell.ItemCount.text == "1" {
            cell.itemPrice.text = "120"
        }else{
            cell.itemPrice.text = String(120 * cell.itemCountInt)
        }
        initialTotalpriceOfItems += Int(cell.itemPrice.text!) ?? 0
        totalItemsPriceLabel.text = String(initialTotalpriceOfItems)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            orderViewModel?.deleteItem(item: models![indexPath.row])
            models?.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func updateTotalPrice(addedPrice : Int){
        var newTotalPrice = initialTotalpriceOfItems + addedPrice
        self.totalItemsPriceLabel?.text = String(newTotalPrice)
    }

    @IBAction func proceed(_ sender: Any) {
       totalItemsPriceLabel.text = "000"
        if models?.count == 0 {
            self.showAlertError(title: "No items", message: "there is no itmes to checkout")
        }
    }
    
    func checkCartIsEmpty() {
        if models?.count == 0{
            tableViewOutlet.isHidden = true
        }
    }
    
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
