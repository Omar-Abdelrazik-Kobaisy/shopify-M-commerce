//
//  MockNetwork.swift
//  E-commerceTests
//
//  Created by Omar on 12/03/2023.
//

import Foundation

import Foundation

@testable import E_commerce

class MockingNetwork
{
    static var errorFlag :  Bool?
    
//    var arr : [BrandItem] = [BrandItem(id: 438822011179, title: "ADIDAS", image: Image(src: "https://cdn.shopify.com/s/files/1/0733/2705/1051/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1678028985&_accept=image/avif")) , BrandItem(id: 438822109483, title: "ASICS TIGER", image: Image(src: "https://cdn.shopify.com/s/files/1/0733/2705/1051/collections/b351cead33b2b72e7177e70512530f09.jpg?v=1678028988&_accept=image/avif"))]
    
    static let mockBrandsResponse : Brands = Brands(smart_collections: [BrandItem(id: 438822011179, title: "ADIDAS", image: Image(src: "https://cdn.shopify.com/s/files/1/0733/2705/1051/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1678028985&_accept=image/avif")) , BrandItem(id: 438822109483, title: "ASICS TIGER", image: Image(src: "https://cdn.shopify.com/s/files/1/0733/2705/1051/collections/b351cead33b2b72e7177e70512530f09.jpg?v=1678028988&_accept=image/avif"))] )
    
    
//    init(errorFlag : Bool)
//    {
//        MockingNetwork.errorFlag = errorFlag
//    }
    
    
//    enum ResponseWithError : Error
//    {
//        case errorflag
//    }
}

extension MockingNetwork : NetworkService{
    static func fetchFromApi<T>(API_URL: String, completion: @escaping (T?) -> Void) where T : Decodable {
        guard let flag = errorFlag else {return}
        if flag  {
            completion(nil)
        }else{
            completion((mockBrandsResponse as! T) )
        }
    }
}
