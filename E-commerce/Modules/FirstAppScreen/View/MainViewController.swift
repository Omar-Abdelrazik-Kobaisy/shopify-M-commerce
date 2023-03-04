//
//  MainViewController.swift
//  E-commerce
//
//  Created by kariman eltawel on 01/03/2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startShopping(_ sender: Any) {
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        ApiService.postToApi(url: "https://48c74805e51e9dc89a6b69d3f0c3e6bf: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@mad-3-ism2023.myshopify.com/admin/api/2023-01/customers.json")
        self.navigationController?.pushViewController(signup, animated: true)
    }
    
    @IBAction func alreadyHaveAccount(_ sender: Any) {
        let already = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(already, animated: true)
    }
    
}
