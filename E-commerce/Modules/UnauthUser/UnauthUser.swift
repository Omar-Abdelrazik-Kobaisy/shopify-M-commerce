//
//  UnauthUser.swift
//  E-commerce
//
//  Created by kariman eltawel on 14/03/2023.
//

import UIKit

class UnauthUser: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func signIn(_ sender: Any) {

        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
        navigationController?.pushViewController(login, animated: true)

    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        navigationController?.pushViewController(signup, animated: true)

    }
    
}
