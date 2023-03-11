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
    
    
    var ObservableGet : (()->()) {
        self.bindingGet
    }
   
    func getAllItems(completion: @escaping (([OrderListModel]? , Error?)->Void)){
        do {
            let cartItmes = try context.fetch(OrderListModel.fetchRequest())

            completion(cartItmes, nil)
        }catch let error{
           completion(nil, error)
        }
    }
    
    func creatItem(product: productItem) {
        do {
            let items = try context.fetch(OrderListModel.fetchRequest())
            if isExist(itemId: product.id!, itemss: items){
           //     self.ObservableGet
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
extension OrderViewModel {
    func SelectedItems(productId: Int64, completion: @escaping (OrderListModel?, Error?)-> Void){
        getAllItems { listing, error in
            if error == nil {
                guard let ordered = listing else { return}
                let CusTomerID = UserDefaults.standard.integer(forKey: "loginid")
                for item in ordered {
                    if item.itemID == productId && item.userID == CusTomerID {
                        completion(item, nil)
                    }
                }
            }else{
                completion(nil, error)
            }
        }
    }
    func save(completion: @escaping (Bool)-> Void){
        do{
            try context.save()
            completion(true)
        }catch{
            print(error.localizedDescription)
            completion(false)
        }
    }
    func saveProduct(){
        save { saveSuccess in
            if saveSuccess{
                print("success ")
            }else{
                print("failed ")
            }
        }
    }
    func calc(completion: @escaping (Double?)-> Void){
        var totalPrice: Double = 0.0
        getAllItems { listing, error in
            if error == nil {
                guard let orders = listing else { return }
                let CusTomerID = UserDefaults.standard.integer(forKey: "loginid")
                
                for item in orders{
                    if item.userID == CusTomerID {
                        guard let StringPrice = item.itemPrice, let price = Double(StringPrice) else { return }
                        totalPrice += Double(item.itemQuantity) * price
                    }
                }
                UserDefaults.standard.set(totalPrice, forKey: "TotalPrice")
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }
    
}

/* getAllItems { lists, error in
 if error == nil {
     guard let order = lists, let customerID = self.customerID else { return }
     for item in order {
         if item.itemID == productId && item.userID == customerID {
             completion(item, nil)
         }
     }
 }else{
     completion(nil, error)
 }
}*/
