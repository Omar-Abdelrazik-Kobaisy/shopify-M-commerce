//
//  product.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation

class ProductImage : Decodable
{
    var id :Int?
    var product_id : Int?
    var src : String?
}
class Prices : Decodable
{
    var id : Int?
    var price : String?
}

class productItem : Decodable
{
    var id : Int?
    var product_type : String?
    var body_html:String?
    var image : ProductImage
    var images:[ProductImage]
    var variants : [Prices]
    var title : String?
}
class product : Decodable {
    var products : [productItem]
}


class ProductDetails : Decodable
{
    var product : productItem

}
