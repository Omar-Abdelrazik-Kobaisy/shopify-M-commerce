//
//  getAddressModel.swift
//  E-commerce
//
//  Created by Mina on 08/03/2023.
//

import Foundation
protocol getAddressNetwrokService {
    static func getAddress(completion: @escaping ((CustomerAddress)?, Error?) -> Void)
}

class getAddrressNetworking : getAddressNetwrokService {
    static func getAddress(completion: @escaping ((CustomerAddress)?, Error?) -> Void){
        let id = UserDefaults.standard.integer(forKey: "loginid")
        let url =  URL(string: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(id)/addresses.json")
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpShouldHandleCookies = false
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { data, response, error in

            if let error = error{
                completion(nil, error)
            }else{
                let json = try? JSONDecoder().decode(CustomerAddress.self, from: data!)
                completion(json, nil)
            }
            
                
        }
        task.resume()
    }
    }


