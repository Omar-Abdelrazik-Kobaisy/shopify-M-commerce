//
//  HomeViewModel.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation
protocol getBrands {
  func getAllBrands()
}

class HomeViewModel : getBrands {
    
    var bindingBrands:(()->())?
    
    var ObservableBrands : Brands? {
        didSet {
            bindingBrands!()
        }
    }
    

    let API_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/smart_collections.json"
    func getAllBrands(){
        ApiService.fetchFromApi(API_URL: API_URL) { [weak self] data in
            self?.ObservableBrands = data
            
        }
    }
}
