//
//  HomeViewModel.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import Foundation

class HomeViewModel
{
    let API_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/smart_collections.json"
    
    var bindingResultToHomeView : ((Brands?) -> Void) = {_ in }
    
    var result : Brands? {
        didSet{
            bindingResultToHomeView(result)
        }
    }
    
    func getBrands()
    {
        ApiService.fetchFromApi(API_URL: API_URL) { [weak self] (data:Brands?) in
            self?.result = data
        }
    }
}
