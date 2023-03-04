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
    var id:String?
    var first_name:String?
    var last_name:String?
    var email:String?
    var password:String?
    var password_confirmation:String?
}


