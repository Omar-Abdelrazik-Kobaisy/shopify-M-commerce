//
//  ProductDetailsViewModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 06/03/2023.
//

import Foundation
protocol getProduct {
    
    func getProductDetails(productId:Int)
    
}

class ProductDetailViewModel : getProduct {
   
    
    var bindingProduct:(()->())?
    
    var ObservableProduct : ProductDetails? {
        didSet {
            bindingProduct!()
        }
    }
    
    func getProductDetails(productId:Int) {
        var API_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products/\(productId).json"
        
        ApiService.fetchFromApi(API_URL: API_URL) { [weak self] (fetchProduct:ProductDetails?) in
            self?.ObservableProduct = fetchProduct

        }
        

    }
    


}
