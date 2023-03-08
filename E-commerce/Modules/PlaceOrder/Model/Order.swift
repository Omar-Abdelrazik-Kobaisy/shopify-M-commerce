//
//  Order.swift
//  E-commerce
//
//  Created by Omar on 08/03/2023.
//

import Foundation


class OrderItem : Decodable
{
    var id : Int?
    var name : String?
    var price : String?
    var quantity : Int?
}

class Order : Decodable
{
    var id : Int?
    var customer : Customer
    var line_items : [OrderItem]
    var created_at : String?
    var current_total_price : String?
    var current_total_discounts : String?
}

class PostOrder : Decodable
{
    var order : Order
}

class GetOrder : Decodable
{
    var orders : [Order]
}
