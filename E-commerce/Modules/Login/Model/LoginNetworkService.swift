//
//  LoginNetworkService.swift
//  E-commerce
//
//  Created by kariman eltawel on 05/03/2023.
//

import Foundation
import Alamofire

protocol LoginNetworkService{
    static func loadDataFromURL( completionHandeler: @escaping ((AllCustomers?), Error?) -> Void)
}
class Login:LoginNetworkService{
    
    
   static func loadDataFromURL( completionHandeler: @escaping ((AllCustomers?), Error?) -> Void){
       let url = URL(string:"https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers.json")
                  guard let url = url else{ return }
                  var req = URLRequest(url: url)
                  req.httpShouldHandleCookies = false
                  let session = URLSession(configuration: URLSessionConfiguration.default)
                  let task = session.dataTask(with: req) { data, response, error in

                      if let error = error{
                          completionHandeler(nil, error)
                      }else{
                          let customerDecode = try? JSONDecoder().decode(AllCustomers.self, from: data!)            
                          completionHandeler(customerDecode, nil)
                      }
                      
                          
                  }
                  task.resume()
              }
    

}
