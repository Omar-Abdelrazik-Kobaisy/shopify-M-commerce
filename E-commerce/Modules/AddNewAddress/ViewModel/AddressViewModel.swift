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
    let id = UserDefaults.standard.integer(forKey: "loginid")
    func setAddress(setaddress: Address) {
       
        AddAddress.CreateAddress(customerId: id, address: setaddress) { check in
            self.ObservableAddress = check
        }
    }
//    func EditAddress(setaddress: Address  , addId: id ){
//        let id = UserDefaults.standard.integer(forKey: "loginid")
//        AddAddress.editAddress(customerId: id, addressID: Address, address: setaddress) { <#Int#> in
//            <#code#>
//        }
        
    //}
}
 
