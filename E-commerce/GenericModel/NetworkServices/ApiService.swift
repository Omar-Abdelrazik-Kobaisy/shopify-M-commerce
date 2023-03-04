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
    
    static func postToApi(url : String)
}


class ApiService : NetworkService
{
    static func postToApi(url: String) {
        let parameters : [String : Any] = [
            "customer": [
//                    "id" : 987,
                    "email": "omar1.abdelrazik@mail.example.com",
                    "first_name": "omar1",
                    "last_name": "abdelrazik1"]]
//        AF.sessionConfiguration.httpShouldSetCookies = false
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default )
//            .responseJSON { response in
////                print(response)
//
//                var json = try? JSONSerialization.jsonObject(with: response.data! , options: .fragmentsAllowed)
//               print(json)
//            }
        

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "post"
        request.httpShouldHandleCookies = false

        do{
            let requestBody = try JSONSerialization.data(withJSONObject: parameters,options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }catch let error
        {
            print(error.localizedDescription)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            let result = String(data: data!, encoding: .utf8)
            print(result!)
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
    
    
}
