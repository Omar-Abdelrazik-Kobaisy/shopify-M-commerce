//
//  WishTableViewCell.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class WishTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var wish_image: UIImageView!
    
    
    @IBOutlet weak var label_wish: UILabel!
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
            
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        contentView.layer.masksToBounds = true
        
        }
    
    

}
