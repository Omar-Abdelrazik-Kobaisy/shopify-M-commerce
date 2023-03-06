//
//  File.swift
//  E-commerce
//
//  Created by kariman eltawel on 06/03/2023.
//

import Foundation



class imageDetail : Decodable{
    var src:String?
}

class Variant : Decodable{
    var price:String?
}


class detail : Decodable
{
    var title:String?
    var body_html:String?
    var variants:[Variant]
    var images:[imageDetail]
}


class ProductDetails : Decodable
{
    var product : detail

}


