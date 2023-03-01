//
//  Brands.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation

class Image : Decodable
{
    var src : String?
}

class BrandItem : Decodable
{
    var id : Int?
    var title : String?
    var image : Image
}

class Brands : Decodable
{
    var smart_collections : [BrandItem]
}
