//
//  AddNewAddressViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//
import UIKit

class AddNewAddressViewController: UIViewController {
    
    @IBOutlet weak var AddAddressBtn: UIButton!
    @IBOutlet weak var CountryTF: UITextField!
    @IBOutlet weak var AddressTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    
    var ViewModel : AddressViewModel?
    var newAddress : Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel = AddressViewModel()
        newAddress = Address()
        textFieldBorder(textField: CountryTF)
        textFieldBorder(textField: AddressTF)
        textFieldBorder(textField: PhoneTF)
        textFieldBorder(textField: CityTF)
        
    }
    
    @IBAction func AddNewAddressBtn(_ sender: Any) {
        checkData()
        if AddressTF.text != "" && CityTF.text != "" && CountryTF.text != "" && PhoneTF.text != "" {
            newAddress?.country = CountryTF.text
            newAddress?.address1 = AddressTF.text
            newAddress?.phone = PhoneTF.text
            newAddress?.city = CityTF.text
            
            guard let address = newAddress else { return }
            ViewModel?.setAddress(setaddress: address)
            
        }
        
    }
    func checkData() {
        let titleMessage = "Missing Data"
        if CountryTF.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your country name")
        }
        
        if CityTF.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your city name")
        }
        
        if AddressTF.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your address")
        }
        
        if PhoneTF.text == "" {
            showAlertError(title: titleMessage, message: "Please enter you phone number")
            
        } else {
            let check: Bool = validate(value: PhoneTF.text!)
            if check == false {
                self.showAlertError(title: "invalid data!", message: "please enter you phone number in correct format")
            }
        }
        
    }
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        print("RESULT \(result)")
        return result
    }
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
     func editBtn()
     {
      AddAddressBtn.backgroundColor = .clear
      AddAddressBtn.layer.cornerRadius = 5
      AddAddressBtn.layer.borderWidth = 1
      AddAddressBtn.layer.borderColor = UIColor.tintColor.cgColor
     }
}
