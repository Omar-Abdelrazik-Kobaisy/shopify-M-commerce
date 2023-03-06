//
//  ViewModel.swift
//  E-commerce
//
//  Created by Omar on 04/03/2023.
//

import Foundation


class ProductsViewModel
{
    
    var bindingproductsBrand:(()->())?
    


    
    var ObservableproductsBrand : product? {
        didSet {
            bindingproductsBrand!()
        }
    }
   
    
    func getproductsBrand(PRODUCTS_BRAND_URL : String)
    {
        ApiService.fetchFromApi(API_URL: PRODUCTS_BRAND_URL) {[weak self] data in
            self?.ObservableproductsBrand = data
        }
    }
    
}
