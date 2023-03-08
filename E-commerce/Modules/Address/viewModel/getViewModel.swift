//
//  getViewModel.swift
//  E-commerce
//
//  Created by Mina on 08/03/2023.
//

import Foundation

class gettingViewModel {
    var bindingGet :(()->())?
    
    var ObservableGet : CustomerAddress? {
        didSet {
            bindingGet!()
        }
    }
    func getAddress() {
        getAddrressNetworking.getAddress { retriveAddress, _ in
            self.ObservableGet = retriveAddress
        }
    }
}



