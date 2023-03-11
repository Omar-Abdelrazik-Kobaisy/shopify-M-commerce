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
        if coupon == "shopify5%" {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            //guard let totalPrice = String(50) else { return} // elmfrod el a7ot el subtotal ely feh el cart
            let totalPrice = 50
            SubTotallbl.text = String(totalPrice)
            result = (Double(String(SubTotallbl.text!))! + 10.00) * 0.95
            guard let paymentMethod = PaymentMethod else { return }
            //totalPriceLabel.text = String(result) + "USD"
            Totallbl.text = String(result) + "USD"
            Paymentlbl.text = paymentMethod
  
        } else if coupon  == "shopify10%" {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            //guard let totalPrice = String(50) else { return} // elmfrod el a7ot el subtotal ely feh el cart
            let totalPrice = 50
            SubTotallbl.text = String(totalPrice)
            result = (Double(String(SubTotallbl.text!))! + 10.00) * 0.9
            Totallbl.text = String(result) + "USD"
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
        } else if coupon  == "shopify15%" {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            //guard let totalPrice = String(50) else { return} // elmfrod el a7ot el subtotal ely feh el cart
            let totalPrice = 50
            SubTotallbl.text = String(totalPrice)
            result = (Double(String(SubTotallbl.text!))! + 10.00) * 0.85
            Totallbl.text = String(result) + "USD"
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
        }
        else {
            guard let coupon = coupon else { return }
            Discountlbl.text = coupon
            Couponlbl.text = coupon + "discount"
            //guard let totalPrice = String(50) else { return} // elmfrod el a7ot el subtotal ely feh el cart
            let totalPrice = 50
            SubTotallbl.text = String(totalPrice)
            result = (Double(String(SubTotallbl.text!))! + 10.00) * 10
            Totallbl.text = String(result) + "USD"
            guard let paymentMethod = PaymentMethod else { return }
            Paymentlbl.text = paymentMethod
        }
    }
    
    
  
    
    @IBAction func PlaceOrderButton(_ sender: Any) {
    }
    
    
