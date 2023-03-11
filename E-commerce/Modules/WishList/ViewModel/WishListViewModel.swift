//
//  WishListViewModel.swift
//  E-commerce
//
//  Created by kariman eltawel on 11/03/2023.
//

import Foundation
class WishListViewModel
{
    
    var bindingWishList:(()->())?


    
    var ObservableWishList : FavoriteProduct? {
        didSet {
            bindingWishList!()
        }
    }
    
    func getWishlist()->[FavoriteProduct]{
        
        CoreDataManager.fetchFromCoreData()

    }

    
    

}
