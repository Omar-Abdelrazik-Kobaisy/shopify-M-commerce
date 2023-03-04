//
//  Category.swift
//  E-commerce
//
//  Created by Omar on 04/03/2023.
//

import Foundation


class CategoryItem : Decodable
{
    var id : Int?
    var title : String?
}

class Category : Decodable
{
    var custom_collections : [CategoryItem]

}
