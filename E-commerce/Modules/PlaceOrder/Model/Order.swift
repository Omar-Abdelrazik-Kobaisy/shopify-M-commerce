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
}

struct Order : Codable{
    var id : Int?
    var customer : Customer
    var line_items : [OrderItem]
    var created_at : String?
    var current_total_price : String?
    var current_total_discounts : String?
}

struct PostOrder : Codable
{
    var order : Order
}

struct GetOrder : Codable
{
    var orders : [Order]
}
