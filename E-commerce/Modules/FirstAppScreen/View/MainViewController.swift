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
//        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func startShopping(_ sender: Any) {
        let HomeScreen = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController")as! HomeTabBarController
        
//        navigationController?.pushViewController(HomeScreen, animated: true)
        HomeScreen.modalPresentationStyle = .fullScreen
        self.present(HomeScreen, animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.navigationController?.pushViewController(signup, animated: true)
    }
    
    @IBAction func alreadyHaveAccount(_ sender: Any) {
        let already = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(already, animated: true)
    }
    
}
