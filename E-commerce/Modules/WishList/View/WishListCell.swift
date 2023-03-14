//
//  WishListCell.swift
//  E-commerce
//
//  Created by kariman eltawel on 12/03/2023.
//

import UIKit

class WishListCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var ProductPrice: UILabel!
    

    @IBOutlet weak var imageProduct: UIImageView!
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
            
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5))
        contentView.layer.masksToBounds = true
        
        }
}
