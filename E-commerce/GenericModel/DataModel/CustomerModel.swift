//
//  CustomerModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 04/03/2023.
//

import Foundation

struct Newcustomer:Codable{
    var customers:[Customer]
}

struct Customer:Codable {
    var id:Int?
    var first_name:String?
    var last_name:String?
    var email:String?
    var note:String?
}


