//
//  Customer.swift
//  E-commerce
//
//  Created by Omar on 04/03/2023.
//

import Foundation

class Customer : Codable
{
//    var id : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
}

class Clients : Codable
{
    var customers : [Customer]
}
