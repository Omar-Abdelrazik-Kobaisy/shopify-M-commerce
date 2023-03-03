//
//  Brands.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation
class Brands : Decodable
{
    var smart_collections : [BrandItem]
}

class BrandItem : Decodable
{
    var id : Int?
    var title : String?
    var image : Image
}

class Image : Decodable
{
    var src : String?
}





