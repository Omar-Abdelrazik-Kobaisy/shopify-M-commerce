//
//  CustomerNetworkManager.swift
//  E-commerce
//
//  Created by kariman eltawel on 04/03/2023.
//

import Foundation
protocol CustomerNetwork{
    static func CustomereRegister(Newcustomer:Customer,complication:@escaping (Int) -> Void)
}
class CustomerReg:CustomerNetwork{

    
    static func CustomereRegister(Newcustomer:Customer,complication:@escaping (Int) -> Void) {

        let url = URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers.json")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        let userDictionary = ["customer": ["first_name": Newcustomer.first_name,
                                           "last_name" : Newcustomer.last_name,
                                           "email": Newcustomer.email,
                                           "note": Newcustomer.note
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
                    let response = String(data:data!,encoding: .utf8)
                     print(response!)
                    complication(httpResponse.statusCode)
                    
                   }
            }
            
        }.resume()
        
        
        
        
    }
    
}
