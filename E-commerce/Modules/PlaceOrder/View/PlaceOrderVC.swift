//
//  PlaceOrderVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit
import CoreMedia
import CoreData
class PlaceOrderVC: UIViewController {
    
    @IBOutlet weak var viewOrder: UIView!
    
    @IBOutlet weak var Deliverylbl: UILabel!
    @IBOutlet weak var Paymentlbl: UILabel!
    @IBOutlet weak var Couponlbl: UILabel!
    @IBOutlet weak var SubTotallbl: UILabel!
    @IBOutlet weak var Discountlbl: UILabel!
    @IBOutlet weak var Shippinglbl: UILabel!
    @IBOutlet weak var Totallbl: UILabel!
    @IBOutlet weak var Feeslbl: UILabel!
    
    var coupon : String?
    var PaymentMethod: String?
    var result = Double()
    
    var models : [OrderListModel]?
    var orderViewModel : OrderViewModel?
    var placeOrderViewModel : PlaceOrderViewMOdel?
        
    var discount : Double?
    var finalTotal : String?
        
    var orders_arr : [OrderItem] = []
    var postOrder : PostOrder?
    var statusCode : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderViewModel = OrderViewModel()
        CalcTotal()
        //rounded view
        viewOrder.layer.borderColor = UIColor.systemYellow.cgColor
        viewOrder.layer.borderWidth = 1
        viewOrder.layer.cornerRadius = 40
        viewOrder.layer.masksToBounds = true
        viewOrder.layer.shadowOffset = CGSizeMake(6, 6)
        viewOrder.layer.shadowColor = UIColor.white.cgColor
        viewOrder.layer.shadowOpacity = 0.1
        viewOrder.layer.shadowRadius = 4
        
        placeOrderViewModel = PlaceOrderViewMOdel()
        
        makeOrder()
       
        
    }
    
    func makeOrder()
    {
        orderViewModel = OrderViewModel()
        
        orderViewModel?.getAllItems { cartItems, error in
            guard let items = cartItems else { return }
            self.models = items
            
        }
        guard let arr = models else {return}
        
        
        for i in 0..<arr.count {
            
            orders_arr.append(OrderItem(id: Int(arr[i].itemID) , name: arr[i].itemName , price: arr[i].itemPrice , quantity: Int(arr[i].itemQuantity), title: arr[i].itemName))
            
            print(Int(arr[i].itemQuantity))
        }
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        let orderDate = formatter.string(from: date)
        print(orderDate)
        
        let order = Order(id:UserDefaults.standard.integer(forKey:"loginid") ,customer: Customer(id: UserDefaults.standard.integer(forKey:"loginid")) , line_items: orders_arr  , total_price: finalTotal ,subtotal_price: finalTotal , total_discounts: String(discount ?? 0.0))
        //, created_at: orderDate
        print(discount ?? 0)
        print(order.total_price)
        postOrder = PostOrder(order: order)
        
        print(postOrder!.convertToDictionary())
        
    }
    
    
    func CalcTotal(){
        if coupon == "5%"
        {
            guard let coupon = coupon else { return }
            Couponlbl.text = coupon + " Discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            result = ((Double(String(SubTotallbl.text!))! + 10.00 )) * 0.95
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - ((Double(String(SubTotallbl.text!))! + 10.00 ) * 0.95)
            finalTotal = String(result)
             if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
             Totallbl.text = String(result) + " EGP"
             Discountlbl.text = "\(discount!)" + " EGP"
             Feeslbl.text = "10 EGP"
             } else {
             SubTotallbl.text = String(totalPrice) + " USD"
             Discountlbl.text = "\(discount!)" + " USD"
             Totallbl.text = String(result) + " USD"
             Feeslbl.text = "10 USD"
               }
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
        }
        
        else if coupon  == "10%"
        {
            guard let coupon = coupon else { return }
            Couponlbl.text = coupon + " Discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 10.00)) * 0.9
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - ((Double(String(SubTotallbl.text!))! + 10.00 ) * 0.9)
            finalTotal = String(result)
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
            Discountlbl.text = "\(discount!)" + " EGP"
            Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " USD"
            Discountlbl.text = "\(discount!)" + " USD"
            Feeslbl.text = "10 USD"
              }
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
        }
        else if coupon  == "15%"
        {
            guard let coupon = coupon else { return }
            Couponlbl.text = coupon + " Discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 10.00)) * 0.85
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - ((Double(String(SubTotallbl.text!))! + 10.00 ) * 0.85)
            finalTotal = String(result)
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
                Discountlbl.text = "\(discount!)" + " EGP"
                Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " EGP"
                Discountlbl.text = "\(discount!)" + " EGP"
                Feeslbl.text = "10 USD"
              }
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
            print("samir")
        }
        else {
            guard let coupon = coupon else { return }
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = Double(String(SubTotallbl.text!))! + 10.0
            discount = 0.0
            finalTotal = String(result)
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
            Discountlbl.text = "\(discount!)"
                Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " USD"
            Discountlbl.text = "\(discount!)"
            Feeslbl.text = "10 USD"
              }
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
           
        }
    }
    
    @IBAction func PlaceOrderButton(_ sender: Any) {

        guard let order = postOrder else {return}
        placeOrderViewModel?.addOrder(order: order)
        placeOrderViewModel?.bindingOrder = {[weak self] code in
                        self?.statusCode = code
                        DispatchQueue.main.async {
                            if self?.statusCode == 201
                            {
                                print("post Success")
                                self?.showAlert(title: "Order", message: "Congratulation 🎉, your order has been placed successfully",flag: true)
                            
                                for i in 0..<self!.models!.count {
                                    UserDefaults.standard.setValue(false, forKey: "cart\(self!.models?[i].itemID ?? 0)")
                                    
                                }
                                
                                for item in self!.models! {
                                    self?.deleteItem(item: item)
                                }
                                
                                
                            }else
                            {
                                print("post fail")
                                self?.showAlert(title: "Order", message: "Fail 🛑, your order not placed try agin",flag: false)
                                
                            }
                        }
            
        }
    }
    func showAlert(title: String, message: String ,flag : Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
        let okAction = flag ? UIAlertAction(title: "OK", style: .destructive, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
            
        }) : UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func deleteItem(item: OrderListModel){
        context.delete(item)
        do {
            try context.save()
        }
        catch {

        }
    }
}
