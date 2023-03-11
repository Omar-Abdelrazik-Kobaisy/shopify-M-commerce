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
    
    var coupon : String?
    var PaymentMethod: String?
    var result = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CalcTotal()
        
    }
    func CalcTotal(){
        if coupon == "5%"
        {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            let totalPrice = UserDefaults.standard.integer(forKey: "final")
            SubTotallbl.text = String(totalPrice)
            result = ((Double(String(SubTotallbl.text!))! + 50.00)) * 0.95
            Totallbl.text = String(result) + "USD"
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
            Totallbl.text = String(result) + "USD"
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
            Totallbl.text = String(result) + "USD"
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
            Totallbl.text = String(result) + "USD"
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
           
        }
    }
    
    @IBAction func PlaceOrderButton(_ sender: Any) {
    }
    
    
}
