//
//  ShopingCartVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 01/03/2023.
//

import UIKit
import Kingfisher
class ShopingCartVC: UIViewController , UITableViewDataSource , UITableViewDelegate , OnCellSelectDelegate{
    func onSelect(price: String) {
        print(finaltotal)
        finaltotal += (price as NSString).integerValue
        print(finaltotal)
        totalItemsPriceLabel.text = String(finaltotal)
    }
    
    
    @IBOutlet weak var totalItemsPriceLabel: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var SubTotallbl: UILabel!
    var models : [OrderListModel]?
    var orderViewModel : OrderViewModel?
    var addedPricetoInitialPOI : Int = 0
    var initialTotalpriceOfItems : Int = 0
    
    var finaltotal : Int = 0
    
    override func viewDidLoad() {
        orderViewModel = OrderViewModel()
        
        /*let addressVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController*/
        
        orderViewModel?.bindingGet = { [weak self] in
            DispatchQueue.main.async {
                self!.models = self!.orderViewModel?.ObservableGet
//                self?.tableViewOutlet.reloadData()
            }
        }
        orderViewModel?.getAllItems { cartItems, error in
            guard let items = cartItems else { return }
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
        cell.itemPrice.text = models?[indexPath.row].itemPrice
        print(cell.itemPrice.text)
        cell.ItemCount.text = String(cell.itemCountInt)
//        cell.configureCell(order: models?[indexPath.row] ?? OrderListModel())
        cell.onCellSelectDelegate = self
        onSelect(price: cell.itemPrice.text ?? "")
//
//        cell.Mina = models?[indexPath.row]
//        //String(models![indexPath.row].itemQuantity)
//
//        if cell.ItemCount.text ==  "1"  {
//         //cell.ItemCount.text = String(models![indexPath.row].itemQuantity)
//
//         cell.itemPrice.text = models?[indexPath.row].itemPrice
//
//     }else{
//         cell.itemPrice.text = String((Int(models?[indexPath.row].itemPrice ?? "") ?? 0) + (cell.itemPrice.text as! NSString).integerValue)
//
//         //models![indexPath.row].itemQuantity+=1
//
//          //cell.ItemCount.text = String(models![indexPath.row].itemQuantity) + String(models![indexPath.row].itemQuantity)
//
//
//         print(cell.itemPrice)
//
//     }
//     cell.temp = (cell.itemPrice.text as! NSString).integerValue
//       // self.updateItem(item: models![indexPath.row], newPrice: String(cell.temp ?? 0) , NewQuantity: (cell.ItemCount.text as! NSString).integerValue)
//     cell.temprary = (cell.ItemCount.text as! NSString).integerValue
//     print(cell.temp)
//     print("seeeeeeee")
//     print(cell.temprary)
//     print(cell.itemPrice.text)
//
//        initialTotalpriceOfItems += Int(cell.itemPrice.text!) ?? 0
//        totalItemsPriceLabel.text = String(initialTotalpriceOfItems)
        
        return cell
    }
    
    func updateItem(item: OrderListModel, newPrice: String , NewQuantity: Int){
        item.itemPrice = newPrice
        item.itemQuantity = Int64(NewQuantity)
        print("itemUpdated")
        do{
            try context.save()
        }
        catch {
            
        }
    }
    
    /* func updateItem(item: ToDoListitem ,newName:String){
     item.name = newName
     do{
         try context.save()
         getAllItems()
     }
     catch {
         
     }
 }*/
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
       //totalItemsPriceLabel.text = "000"
        if models?.count == 0 {
            self.showAlertError(title: "No items", message: "there is no itmes to checkout")
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
