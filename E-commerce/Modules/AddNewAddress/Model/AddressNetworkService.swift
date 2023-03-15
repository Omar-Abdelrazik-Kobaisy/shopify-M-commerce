//
//  AddressNetworkService.swift
//  E-commerce
//
//  Created by Mina on 07/03/2023.
//

import Foundation
protocol AddressNetwork {
    static func CreateAddress(customerId: Int, address : Address,completion:@escaping (Int) -> Void)
}
protocol EditNetwork {
    static func editAddress(customerId: Int,addressID: Int, address : [String: Any],completion:@escaping (Int) -> Void)
}
class AddAddress : AddressNetwork , EditNetwork{
    static func CreateAddress(customerId: Int, address : Address,completion:@escaping (Int) -> Void) {
        let url = URL(string:"https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(customerId).json")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PUT"
        let AddressDictionary : [String : Any] = ["customer" : [ "addresses" : [["address1" : address.address1 ,"city" : address.city , "country" : address.country , "phone" : address.phone ]]]]
        urlRequest.httpShouldHandleCookies = false
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: AddressDictionary, options: .prettyPrinted)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
        } catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data , response, error) in
            if(data != nil && data?.count != 0) {
                let response = String(data: data! , encoding: .utf8)
                print( response!)
            }
            
        }.resume()
    }
    
    static func editAddress(customerId: Int,addressID: Int, address : [String: Any],completion:@escaping (Int) -> Void) {
        let url = URL(string:"https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(customerId)/addresses/\(addressID).json")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpShouldHandleCookies = false
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: address, options: .prettyPrinted)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
        } catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data , response, error) in
            if(data != nil && data?.count != 0) {
                let response = String(data: data! , encoding: .utf8)
                print( response!)
            }
            
        }.resume()
    }
}
