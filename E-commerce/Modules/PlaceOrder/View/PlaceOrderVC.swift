//
//  PlaceOrderVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit

class PlaceOrderVC: UIViewController {
    
    
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
        
        var orders_arr : [OrderItem] = []
        var postOrder : PostOrder?
    var statusCode : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CalcTotal()
        
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
        
        let order = Order(id:UserDefaults.standard.integer(forKey:"loginid") ,customer: Customer(id: UserDefaults.standard.integer(forKey:"loginid")) , line_items: orders_arr  , current_total_price: Totallbl.text ,current_subtotal_price: Totallbl.text , total_discounts: String(discount ?? 0.0))
        //, created_at: orderDate
        print(discount ?? 0)
        print(order.current_total_price)
        postOrder = PostOrder(order: order)
        
        print(postOrder!.convertToDictionary())
        
    }
    
    
    func CalcTotal(){
        if coupon == "5%"
        {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 10.00 )) * 0.95
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - (Double(String(SubTotallbl.text!))!) * 0.95
             if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
             Totallbl.text = String(result) + " EGP"
                 Feeslbl.text = "10 EGP"
             } else {
             Totallbl.text = String(result) + " USD"
                 Feeslbl.text = "10 USD"
               }
           // Totallbl.text = String(result) + "USD"
            print(Totallbl.text)
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
            
            print("mina")
            print(result)
            
        }
        else if coupon  == "10%"
        {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 10.00)) * 0.9
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - (Double(String(SubTotallbl.text!))!) * 0.9
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
                Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " USD"
                Feeslbl.text = "10 USD"
              }
            guard let paymentMethod = PaymentMethod else { return }
            print("eid")
            Paymentlbl.text = paymentMethod
        }
        else if coupon  == "15%"
        {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 10.00)) * 0.85
            discount = (Double(String(SubTotallbl.text!))! + 10.00) - (Double(String(SubTotallbl.text!))!) * 0.85
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
                Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " USD"
                Feeslbl.text = "10 USD"
              }
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
            print("samir")
        }
        else {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = Double(String(SubTotallbl.text!))! + 10.0
            discount = 0.0
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Totallbl.text = String(result) + " EGP"
                Feeslbl.text = "10 EGP"
            } else {
            Totallbl.text = String(result) + " USD"
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
                                self?.showAlert(title: "Order", message: "Congratulation 🎉, your order has been placed successfully")
                            }else
                            {
                                print("post fail")
                                self?.showAlert(title: "Order", message: "Fail 🛑, your order not placed try agin")
                            }
                        }
            
        }
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
