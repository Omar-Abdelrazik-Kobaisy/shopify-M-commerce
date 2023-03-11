//
//  PaymentViewController.swift
//  E-commerce
//
//  Created by Mina on 05/03/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var ApplePayOption: UIButton!
    @IBOutlet weak var CashOnDeliveryOption: UIButton!
    @IBOutlet weak var CouponTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(UserDefaults.standard.string(forKey: "address"))
    }
    
    
    func checkCopon(){
        let placeOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
        if ApplePayOption.isSelected {
            placeOrderVC.PaymentMethod = "Apple Pay"
           
        }
        else if CashOnDeliveryOption.isSelected{
            placeOrderVC.PaymentMethod = "Cash on delivery"
           
        } else  {
            self.showAlert(title: "No Method is selected", message: "Please Select Payment Method")
        }
        
        if CouponTF.text == "shopify5%" {
            placeOrderVC.coupon = "5%"
        }
        else if CouponTF.text == "shopify10%" {
            placeOrderVC.coupon = "10%"
        }
        else if CouponTF.text == "shopify15%" {
            placeOrderVC.coupon = "15%"
        }
        else if CouponTF.text == "" {
            placeOrderVC.coupon = "NO"
        }
        else if CouponTF.text != "shopify5%" ||  CouponTF.text != "shopify10%" ||  CouponTF.text != "shopify15%" {
            self.showAlert(title: "Not Valid Coupon", message: "Please Enter A valid Coupon")
        }
        CouponTF.text = ""
        self.navigationController?.pushViewController(placeOrderVC, animated: false)
        
    }
    func showAlert(title: String , message: String){
        let alert = UIAlertController(title: title ,message : message
                                      , preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(OkAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func ApplePay(_ sender: Any) {
        OptionSelected(_isApplePaySelected: true)
        
    }
    
    @IBAction func cashOnDelivery(_ sender: Any) {
        OptionSelected(_isApplePaySelected: false)
    }
    
    @IBAction func ContinueTocheck(_ sender: Any) {
        checkCopon()
    }
    func OptionSelected(_isApplePaySelected: Bool) {
        if _isApplePaySelected {
            self.ApplePayOption.isSelected = true
            ApplePayOption.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            self.CashOnDeliveryOption.isSelected = false
            CashOnDeliveryOption.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            self.ApplePayOption.isSelected = false
            ApplePayOption.setImage(UIImage(systemName: "circle"), for: .normal)
            self.CashOnDeliveryOption.isSelected = true
            CashOnDeliveryOption.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
    }
}
