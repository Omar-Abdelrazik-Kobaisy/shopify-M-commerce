//
//  SignUpViewController.swift
//  E-commerce
//
//  Created by kariman eltawel on 01/03/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    var ViewModel:SignUpViewModel?
    var newCustomer:Customer?
    var confirmPasswordCheck :String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewModel = SignUpViewModel()
        newCustomer = Customer()
        textFieldBorder(textField: userName)
        textFieldBorder(textField: lastName)
        textFieldBorder(textField: email)
        textFieldBorder(textField: password)
        textFieldBorder(textField: ConfirmPassword)
        
        

            
        
        
    }
    

    @IBAction func signUpAction(_ sender: Any) {
        newCustomer?.first_name = userName.text
        print(userName.text!)
        newCustomer?.last_name = lastName.text
        newCustomer?.email = email.text
        newCustomer?.note = password.text
        confirmPasswordCheck = ConfirmPassword.text
        
        
        
        guard let customer = newCustomer else{
            return
        }
        ViewModel?.setCustomer(setcustomer: customer)
        
        
        ViewModel?.bindingSignUp = { [weak self] in
            DispatchQueue.main.async {
                
                print("ObservableSignUp")
                
                if self?.ViewModel?.ObservableSignUp  == 201{
                    
                    self?.showToast(message: "Account Created", seconds: 2.0)
                }
                else{
                    self?.showToast(message: "Check your Input", seconds: 2.0)
                }
                
            }
            
        }
        
        
    }
            

        
    
    
    func showToast(message : String, seconds: Double){
        
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
            alert.view.backgroundColor = .orange
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }
}
