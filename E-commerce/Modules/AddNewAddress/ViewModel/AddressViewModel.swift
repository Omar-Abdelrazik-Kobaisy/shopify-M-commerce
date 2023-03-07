//
//  AddressViewModel.swift
//  E-commerce
//
//  Created by Mina on 07/03/2023.
//

import Foundation
class AddressViewModel{
    
    var bindingAddress:(()->())?
    
    var ObservableAddress : Int? {
        didSet {
            bindingAddress!()
        }
    }
    func setAddress(setaddress: Address) {
        let id = UserDefaults.standard.integer(forKey: "loginid")
        AddAddress.CreateAddress(customerId: id, address: setaddress) { check in
            self.ObservableAddress = check
        }
    }
}
 
