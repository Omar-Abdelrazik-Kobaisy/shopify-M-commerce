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
    @IBOutlet weak var SubTotallbl: UILabel!
    var models : [OrderListModel]?
    var orderViewModel : OrderViewModel?

    override func viewDidLoad() {
        orderViewModel = OrderViewModel()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        orderViewModel?.getAllItems { cartItems, error in
            guard let items = cartItems else { return }
            self.models = items
            
        }
        DispatchQueue.main.async {
            
            self.tableViewOutlet.reloadData()
        }
        
        checkCartIsEmpty()
        TotalPrice()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for: indexPath) as! ShopingCartTableViewCell
        let url = URL(string: models![indexPath.row].itemImage!)
        cell.itemImage.kf.setImage(with: url)
        cell.itemName.text = models![indexPath.row].itemName
        //cell.itemPrice.text = models?[indexPath.row].itemPrice
        
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            cell.itemPrice.text = (models?[indexPath.row].itemPrice!)! + " EGP"
        } else {
            cell.itemPrice.text = (models?[indexPath.row].itemPrice!)! + " USD"
          }
        
        cell.addQuantity = {
            self.orderViewModel?.SelectedItems(productId: self.models![indexPath.row].itemID) { chosen , error in
                if chosen != nil {
                    chosen?.itemQuantity+=1
                    
                }
                self.orderViewModel?.saveProduct()
            }
            self.tableViewOutlet.reloadData()
            self.TotalPrice()
        }
        cell.subQuantity = {
            if self.models![indexPath.row].itemQuantity > 1 {
                self.orderViewModel?.SelectedItems(productId: self.models![indexPath.row].itemID) { chosen , error in
                    if chosen != nil {
                        chosen?.itemQuantity-=1
                    }
                    self.orderViewModel?.saveProduct()
                }
            }
            self.tableViewOutlet.reloadData()
            self.TotalPrice()
        }
        cell.ItemCount.text = String(models![indexPath.row].itemQuantity)
            return cell
        }
        
        func TotalPrice(){
            orderViewModel!.calc { totalPrice in
                guard let totalPrice = totalPrice else { return }
                UserDefaults.standard.set(totalPrice, forKey: "final")
                
                 if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                 self.totalItemsPriceLabel.text = String(totalPrice) + " EGP"
                 } else {
                 self.totalItemsPriceLabel.text = String(totalPrice) + " USD"
                   }
                 
                UserDefaults.standard.set(totalPrice, forKey: "final")

                //self.totalItemsPriceLabel.text = String(totalPrice) + " USD"
            }
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion ?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [weak self] action in
                    self!.orderViewModel?.deleteItem(item: self!.models![indexPath.row])
                    self!.models?.remove(at: indexPath.row)
                    self!.tableViewOutlet.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        @IBAction func proceed(_ sender: Any) {
            if models?.count == 0 {
                self.showAlertError(title: "No items", message: "there is no itmes to checkout")
            }
            else {
                let SelectVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressViewController") as! SelectAddressViewController
                self.navigationController?.pushViewController(SelectVC, animated: true)
            }
        }
        
        func checkCartIsEmpty() {
            if models?.count == 0{
                tableViewOutlet.isHidden = true
                SubTotallbl.isHidden = true
                totalItemsPriceLabel.isHidden = true
            }
        }
        
        func showAlertError(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
