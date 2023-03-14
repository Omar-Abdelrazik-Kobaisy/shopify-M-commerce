//
//  CategoryCollectionViewCell.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
   
    var favProd:(()->())?

    
    
    @IBOutlet weak var product_image: UIImageView!
    
    @IBOutlet weak var product_name: UILabel!
    
    
    @IBOutlet weak var product_price: UILabel!
    
    @IBOutlet weak var favourite_btn: UIButton!
    
    
    @IBAction func FavButtonAction(_ sender: Any) {
        favProd?()
    }
}
