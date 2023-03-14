//
//  OrderTableViewCell.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var order_price: UILabel!
    
    
    @IBOutlet weak var order_createdat: UILabel!
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
            
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        contentView.layer.masksToBounds = true
        
        }

}
