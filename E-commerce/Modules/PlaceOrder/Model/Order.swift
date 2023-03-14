//
//  Order.swift
//  E-commerce
//
//  Created by Omar on 08/03/2023.
//

import Foundation


struct OrderItem : Codable {
    var id : Int?
    var name : String?
    var price : String?
    var quantity : Int?
    var title:String?
}

struct Order : Codable{
    var id : Int?
    var customer : Customer
    var line_items : [OrderItem]
    var created_at : String?
    var total_price : String?
    var subtotal_price : String?
    var total_discounts : String?
}

struct PostOrder : Codable
{
    var order : Order
    func convertToDictionary() -> [String : Any]
        {
            var dictionary : [String : Any] = [:]
            do{
                let data = try JSONEncoder().encode(self)
                dictionary = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as? [String : Any] ?? [:]
            }catch let error
            {
                print(error.localizedDescription)
            }
            return dictionary
        }
}

struct GetOrder : Codable
{
    var orders : [Order]
    
}
