//
//  OrderViewModel.swift
//  E-commerce
//
//  Created by Mina on 08/03/2023.
//

import Foundation
import CoreMedia
class OrderViewModel {
    
    let customerId = UserDefaults.standard.integer(forKey: "loginid")
    var bindingGet: (()->()) = {}
    var ObservableGet : [OrderListModel] = [] {
        didSet{
            bindingGet()
        }
    }
    
    func getAllItems(completion: @escaping (([OrderListModel]? , Error?)->Void)){
        do {
            let cartItmes = try context.fetch(OrderListModel.fetchRequest())
            ObservableGet = cartItmes
            completion(cartItmes, nil)
        }catch let error{
           completion(nil, error)
        }
    }
    
    func creatItem(product: productItem) {
        do {
            let items = try context.fetch(OrderListModel.fetchRequest())
            if isExist(itemId: product.id!, itemss: items){
            } else {
                let orderItem = OrderListModel(context: context)
                orderItem.itemID = Int64(product.id!)
                orderItem.itemName = product.title
                orderItem.itemImage = product.image.src
                orderItem.itemPrice = product.variants[0].price
                orderItem.itemQuantity = 1
                orderItem.userID = Int64(customerId)
                try context.save()
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    func isExist(itemId: Int, itemss:[OrderListModel]) -> Bool{
            var check : Bool = false
            for i in itemss {
                if i.itemID == itemId {
                    check = true
                } else {
                    check = false
                }
            }
            return check
        }
    }
    
    func deleteItem(item: OrderListModel){
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            
        }
    }
}

