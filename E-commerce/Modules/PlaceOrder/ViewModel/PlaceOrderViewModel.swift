//
//  PlaceOrderViewModel.swift
//  E-commerce
//
//  Created by Omar on 12/03/2023.
//

import Foundation

class PlaceOrderViewMOdel
{
    var bindingOrder:((Int)->Void) = {_ in }
    
    var statusCode : Int = 0 {
        didSet{
            bindingOrder(statusCode)
        }
    }
    
    func addOrder(order: PostOrder)
    {
        ApiService.postOrderToApi(order: order) { [weak self] code in
            self?.statusCode = code
        }
    }
    
}
