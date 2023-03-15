//
//  cartItems.swift
//  E-commerce
//
//  Created by Omar on 15/03/2023.
//

import Foundation

class CartItems {
    
    static let sharedIstance = CartItems()
    
    private init(){
        
    }
    
    var models : [OrderListModel]?
    var orderViewModel : OrderViewModel?
    
    func getAllCartItems() -> [OrderListModel]{
        orderViewModel = OrderViewModel()
        
        orderViewModel?.getAllItems { cartItems, error in
            guard let items = cartItems else { return }
            self.models = items
            
        }
        guard let arr = models else {return []}
        return arr
    }
}
