//
//  CategoryViewModel.swift
//  E-commerce
//
//  Created by Omar on 06/03/2023.
//

import Foundation
class CategoryViewModel
{
    let CATEGORY_URL = "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/custom_collections.json"
    
//    "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/custom_collections.json"
//
    
    var bindingCategory:((Category?)->Void) = {_ in }
    var bindingCategoryId:(([Int])->Void) = {_ in }
    var bindingProductsCategory:((product?)->Void) = {_ in }
    
    var category : Category?
    {
        didSet
        {
            bindingCategory(category)
        }
    }
    var arr_category_id : [Int] = []
    {
        didSet
        {
            bindingCategoryId(arr_category_id)
        }
    }
    
    
    var products : product?
    {
        didSet
        {
            //binding
            bindingProductsCategory(products)
        }
    }
    
   
    
    
    
    func getCategory()
    {
        ApiService.fetchFromApi(API_URL: CATEGORY_URL) { [weak self] data in
            self?.category = data
            
            for i in 1..<(self?.category?.custom_collections.count ?? 0)
            {
                self?.arr_category_id.append(self?.category?.custom_collections[i].id ?? 0)
            }
        }
    }
    
    
    func getProductsCategory(url : String)
    {
        ApiService.fetchFromApi(API_URL: url) { [weak self] data in
            self?.products = data
        }
    }
    
    
}
