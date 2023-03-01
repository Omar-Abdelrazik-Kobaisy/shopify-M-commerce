//
//  BrandsCollectionViewCell.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Brand_imageV: UIImageView!
    
    @IBOutlet weak var Brand_title: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.layer.masksToBounds = true
    }
}
