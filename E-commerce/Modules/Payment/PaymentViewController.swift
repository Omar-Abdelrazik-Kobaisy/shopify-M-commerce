//
//  PaymentViewController.swift
//  E-commerce
//
//  Created by Mina on 05/03/2023.
//

import UIKit
import PassKit
class PaymentViewController: UIViewController {

    @IBOutlet weak var ApplePayOption: UIButton!
    @IBOutlet weak var CashOnDeliveryOption: UIButton!
    @IBOutlet weak var CouponTF: UITextField!
    
    private var paymentRequest : PKPaymentRequest = {
      let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.pushpendra.pay"
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "EG"
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
         request.currencyCode = "EGP"
     } else {
         request.currencyCode = "US"
       }
       // request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: UserDefaults.standard.integer(forKey: "final")))]
        return request
    }()
    
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
        Payment()
        
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
    func Payment(){
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            present(controller!,  animated: true ,completion: nil)
        }
    }
    
}
extension PaymentViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController , didAuthorizePaymentpayment: PKPayment , handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

}
/*  func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController , didAuthorizePayment payment: PKPayment , handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){
 completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
}*/

