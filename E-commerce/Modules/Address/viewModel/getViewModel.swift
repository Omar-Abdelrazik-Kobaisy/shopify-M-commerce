//
//  getViewModel.swift
//  E-commerce
//
//  Created by Mina on 08/03/2023.
//

import Foundation

class gettingViewModel {
    var bindingGet :(()->())?
    var bindingStatusCode :((Int)->Void) = {_ in }
   
    var statusCode : Int = 0{
        didSet{
            bindingStatusCode(statusCode)
        }
    }
    
    var ObservableGet : CustomerAddress? {
        didSet {
            bindingGet!()
        }
    }
    
    func deleteAddress(AddressId : Int , CustomerId : Int){
        ApiService.deleteAddress(Address_Id: AddressId, Customer_Id: CustomerId) { [weak self] code in
            self?.statusCode = code
        }
    }
    
    
    func getAddress() {
        getAddrressNetworking.getAddress { retriveAddress, _ in
            self.ObservableGet = retriveAddress
        }
    }
}



