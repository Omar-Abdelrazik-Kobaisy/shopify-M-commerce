//
//  Products.swift
//  E-commerce
//
//  Created by Omar on 04/03/2023.
//

import Foundation


class ProductDetails : Decodable
{
    var id : Int?
    var price : String?
}


class productItemDetails : Decodable
{
    var id : Int?
    var vendor : String?
    var product_type :String?
    var variants : [ProductDetails]
}


class Products : Decodable {
    var products : [productItemDetails]
}
