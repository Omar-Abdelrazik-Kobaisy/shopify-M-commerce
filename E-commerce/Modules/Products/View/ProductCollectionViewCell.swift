//
//  ProductCollectionViewCell.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    var favProd:(()->())?

    
    @IBOutlet weak var product_image: UIImageView!
    
    
    
    @IBOutlet weak var product_price: UILabel!
    
    
    @IBOutlet weak var product_name: UILabel!
    
    
    @IBOutlet weak var product_fav: UIButton!
    
    
    @IBAction func FavButtonAction(_ sender: Any) {
        favProd?()

    }
    
}
