//
//  LoginViewController.swift
//  E-commerce
//
//  Created by kariman eltawel on 01/03/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldBorder(textField: username)
        textFieldBorder(textField: password)

    }
    

}

func textFieldBorder(textField:UITextField){
    textField.layer.cornerRadius = 15.0
    textField.layer.borderWidth = 2.0
    textField.layer.borderColor = UIColor.orange.cgColor
}
