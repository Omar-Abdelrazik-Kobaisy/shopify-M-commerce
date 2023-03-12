//
//  Brands.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation
struct Brands : Decodable
{
    var smart_collections : [BrandItem]
}

struct BrandItem : Decodable
{
    var id : Int?
    var title : String?
    var image : Image
}

struct Image : Decodable
{
    var src : String?
}





