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
class AddAddress : AddressNetwork {
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
}
/*class AddressNetworking {
    static var shared = AddressNetworking()
    
    
}
extension AddressNetworking {
    func createAddress(customerId: Int, address : Address, completion: @escaping(Data?, URLResponse?, Error?) ->()){
        let customer = CustomerAddress(addresses: [address])
        let putObject = PutAddress(customer: customer)

        var request = URLRequest(url: URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(customerId).json")!)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: putObject, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error )in
            completion(data, response, error)
        }.resume()
    }
}*/
/* func registerUser(){
 var urlRequest = URLRequest(url: URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/6847510675755.json")!)
 urlRequest.httpMethod = "PUT"
 let dataDictionary : [String : Any] = ["customer" : [ "addresses" : [["address1" : "13 saed St" ,"city" : "cairo" , "country" : "egypt" , "phone" :"01208784135"]]]]
 urlRequest.httpShouldHandleCookies = false
 
 do {
     let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
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
 
}*/
