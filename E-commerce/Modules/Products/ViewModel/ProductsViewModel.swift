//
//  ProductsViewModel.swift
//  E-commerce
//
//  Created by Omar on 04/03/2023.
//

import Foundation

class ProductsViewModel
{
    
    var bindingproductsBrand:(()->())?
    var bindingproduct:(()->())?


    
    var ObservableproductsBrand : product? {
        didSet {
            bindingproductsBrand!()
        }
    }
    var Observableproduct : Products? {
        didSet {
            bindingproduct!()
        }
    }
    
    func getproductsBrand(PRODUCTS_BRAND_URL : String)
    {
        ApiService.fetchFromApi(API_URL: PRODUCTS_BRAND_URL) {[weak self] data in
            self?.ObservableproductsBrand = data
        }
    }
    
    func getproduct(PRODUCT_DETAILS_URL :String)
    {
        ApiService.fetchFromApi(API_URL: PRODUCT_DETAILS_URL) {[weak self] data in
            self?.Observableproduct = data
        }
    }
}
