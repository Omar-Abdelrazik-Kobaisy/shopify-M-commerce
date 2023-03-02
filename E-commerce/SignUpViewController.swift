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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldBorder(textField: userName)
        textFieldBorder(textField: email)
        textFieldBorder(textField: password)
        textFieldBorder(textField: ConfirmPassword)

    }
    


}
