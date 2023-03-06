//
//  LoginViewModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 05/03/2023.
//

import Foundation

class loginViewModel{
    
    var bindingLogin:(()->())?
    
    var ObservableLogin : AllCustomers? {
        didSet {
            bindingLogin!()
        }
    }
    
    func getCustomer(){
        Login.loadDataFromURL { retrivecustomer,_ in
            self.ObservableLogin = retrivecustomer
        }
    }
    
    func AuthCustomer(customerEmail:String,customerPasssword:String)->Int{
        var x = 0
        
        if let obserable = ObservableLogin {
            print(obserable.customers.count)
            for i in 0..<(obserable.customers.count){
                if customerEmail == obserable.customers[i].email && customerPasssword == obserable.customers[i].note{
                    x = 1
                }
                
        }
          
        }
        return x

    }
}
