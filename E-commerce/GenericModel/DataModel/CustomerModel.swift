//
//  CustomerModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 04/03/2023.
//

import Foundation

class Newcustomer:Codable{
    var customers:[Customer]
}

class Customer:Codable{
    var id:Int?
    var first_name:String?
    var last_name:String?
    var email:String?
    var note:String?
}


