//
//  PlaceOrderVC.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit

class PlaceOrderVC: UIViewController {

    
    @IBOutlet weak var SubTotalLabel: UILabel!
    
    @IBOutlet weak var ShippingFeesLabel: UILabel!
    
    @IBOutlet weak var CouponStatusLabel: UILabel!
    @IBOutlet weak var CouponTextField: UITextField!
    
    @IBOutlet weak var DiscountLabel: UILabel!
    
    @IBOutlet weak var GrandTotalLabel: UILabel!
    
    
    var subTotal : Int?
    var shippingFees : Int = 30
    var discount : Int = 0
    var grandTotal : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        subTotal = 100
        SubTotalLabel.text = String(subTotal!)
        ShippingFeesLabel.text = String(shippingFees)
        grandTotal = subTotal! - (shippingFees + discount)
        GrandTotalLabel.text = String(grandTotal!)
        
        
    }
    
    @IBAction func ApplyCouponButton(_ sender: Any) {
        if CouponTextField.text == "disc10"{
            CouponStatusLabel.text = "valid"
            discount = 10
            DiscountLabel.text = "10"
        }else{
            CouponStatusLabel.text = "Invalid"
        }
        grandTotal = subTotal! - (shippingFees + discount)
        GrandTotalLabel.text = String(grandTotal!)
    }
    
    @IBAction func PlaceOrderButton(_ sender: Any) {
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
