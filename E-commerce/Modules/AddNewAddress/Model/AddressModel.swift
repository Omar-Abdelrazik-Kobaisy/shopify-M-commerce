//
//  AddressModel.swift
//  E-commerce
//
//  Created by Mina on 07/03/2023.
//

import Foundation

//struct NewCustomer: Codable {
//    let customer: Customer
//}

//struct Customers : Codable {
//    let customers : [Customer]?
//}
//struct customers : Codable {
//    let cusTomers : [customer]?
//}
//struct customer : Codable {
//    let first_name, last_name, email, phone, tags: String?
//    let id: Int?
//    let verified_email: Bool?
//    let addresses: [Address]?
//}

struct Address: Codable {
    var address1, city, country, phone: String?
    
}

struct CustomerAddress: Codable {
    var addresses: [Address]?
}

struct UpdateAddress: Codable {
    var address: Address
}

struct PutAddress: Codable {
    let customer: CustomerAddress?
}
/*struct NewCustomer : Codable {
    let customer: Customer
}
struct Customers: Codable {
    let customers: [Customer]
}
struct Customer : Codable {
    let first_name , last_name , email, phone : String?
    let id: Int?
    let addresses: [Address]?
}

struct Address : Codable {
    var address1 , city , province , phone :String?
    var zip , last_name , first_name , country :String?
    let id: Int?
}

struct CustomerAddress: Codable {
    var addressess: [Address]?
}

struct UpdateAddress: Codable {
    var address :Address
}

struct PutAddress: Codable {
    let customer: CustomerAddress?
}*/

