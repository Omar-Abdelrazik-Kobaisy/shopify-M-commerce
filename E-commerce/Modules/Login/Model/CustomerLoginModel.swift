//
//  CustomerLoginModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 05/03/2023.
//

import Foundation
class AllCustomers : Decodable{
    
    let customers : [CustomerLogin]
}

class CustomerLogin: Decodable {
    let id: Int?
    let email: String?
    let note:String?
}


