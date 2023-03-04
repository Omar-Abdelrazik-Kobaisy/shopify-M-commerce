//
//  CustomerNetworkManager.swift
//  E-commerce
//
//  Created by kariman eltawel on 04/03/2023.
//

import Foundation
protocol CustomerNetwork{
   static func CustomereRegister(Newcustomer:Customer)
}
class CustomerReg:CustomerNetwork{
    
    static var satatusCodeCheck:Int?

    
    static func CustomereRegister(Newcustomer:Customer) {

        let url = URL(string: "https://48c74805e51e9dc89a6b69d3f0c3e6bf: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@mad-3-ism2023.myshopify.com/admin/api/2023-01/customers.json")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        let userDictionary = ["customer": ["first_name": Newcustomer.first_name,
                                           "last_name" : Newcustomer.last_name,
                                           "email": Newcustomer.email,
                                           "password": Newcustomer.password,
                                           "password_confirmation":Newcustomer.password_confirmation
                                          ]]
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
                    satatusCodeCheck = httpResponse.statusCode
                   }
            }
            
        }.resume()
        
        
        
        
    }
    
}
