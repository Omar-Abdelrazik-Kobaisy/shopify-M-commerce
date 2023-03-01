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
    static func fetchFromApi<T : Decodable>( API_URL:String ,complition : @escaping (T?)-> Void)
}


class ApiService : NetworkService
{
    static func fetchFromApi<T>(API_URL: String, complition: @escaping (T?) -> Void) where T : Decodable {
        AF.request(API_URL).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                
                complition(result)
                
            }catch let error
            {
                complition(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    
}
