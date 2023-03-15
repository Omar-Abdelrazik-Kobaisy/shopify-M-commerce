//
//  NetworkManger.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import Foundation
import Alamofire

protocol NetworkService
{
    static func fetchFromApi<T : Decodable>( API_URL:String ,completion : @escaping (T?)-> Void)
    
  
}
protocol NetworkServicePost{
    static func postOrderToApi(order : PostOrder,complication:@escaping (Int) -> Void)
}
protocol NetworkServiceDel{
    static func deleteAddress(Address_Id : Int ,Customer_Id : Int ,complication:@escaping (Int) -> Void)
}


class ApiService : NetworkService , NetworkServicePost , NetworkServiceDel
{
    static func deleteAddress(Address_Id: Int, Customer_Id: Int, complication: @escaping (Int) -> Void) {
        let url = URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(Customer_Id)/addresses/\(Address_Id).json")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
//        urlRequest.httpShouldHandleCookies = false
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if (data != nil && data?.count != 0){
                if let httpResponse = response as? HTTPURLResponse {
                    let response = String(data:data!,encoding: .utf8)
                     print(response!)
                    complication(httpResponse.statusCode)
                    
                   }
                }
               }.resume()
    }
    
    
    
    
    static func fetchFromApi<T>(API_URL: String, completion: @escaping (T?) -> Void) where T : Decodable {
        AF.request(API_URL).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                
                completion(result)
                
            }catch let error
            {
                completion(nil)
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    static func postOrderToApi(order: PostOrder,complication:@escaping (Int) -> Void) {
        let url = URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/orders.json")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpShouldHandleCookies = false
//        var dictionary : [String:Any] = [:]
                    //this comment made by me --> dont forget order.convertToDictionary() <--
        do {
            let bodyDictionary = try JSONSerialization.data(withJSONObject: order.convertToDictionary(),options: .prettyPrinted)

            urlRequest.httpBody = bodyDictionary
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        } catch let error {
            print(error.localizedDescription)
            print("catch")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (data != nil && data?.count != 0){
                if let httpResponse = response as? HTTPURLResponse {
                    let response = String(data:data!,encoding: .utf8)
                     print(response!)
                    complication(httpResponse.statusCode)
                    
                   }
                }
               }.resume()
    }
    
    static func updateAddress(customer_id : Int , address_id : Int , address : String,complication:@escaping (Int) -> Void) {

        let url = URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(customer_id)/addresses/\(address_id)/default")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PUT"
        let userDictionary = ["customer_address" :
                                ["id": address_id ,"customer_id" : customer_id, "address1" :"\(address)" , "default": true]
        ]
        print(userDictionary)
        urlRequest.httpShouldHandleCookies = false
        do {
            
            let bodyDictionary = try JSONSerialization.data(withJSONObject: userDictionary,options: .prettyPrinted)
            urlRequest.httpBody = bodyDictionary
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (data != nil && data?.count != 0){
                if let httpResponse = response as? HTTPURLResponse {
                    let response = String(data:data!,encoding: .utf8)
                     print(response!)
                    complication(httpResponse.statusCode)
                    
                   }
            }
            
        }.resume()
        
        
        
        
    }
  
}
