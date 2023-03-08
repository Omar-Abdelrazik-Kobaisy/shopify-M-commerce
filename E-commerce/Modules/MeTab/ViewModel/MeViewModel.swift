//
//  MeViewModel.swift
//  E-commerce
//
//  Created by Omar on 08/03/2023.
//

import Foundation

class MeViewModel
{
    var bindingResultToMeTab: ((GetOrder?)->Void) = {_ in }
    
    var result : GetOrder? {
        didSet{
            bindingResultToMeTab(result)
        }
    }
    
    func getOrders(url:String)
    {
        ApiService.fetchFromApi(API_URL: url) { [weak self] data in
            self?.result = data
            }
    }
    
}
