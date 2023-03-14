//
//  OrderDetialsTableViewCell.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit

class OrderDetialsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var ItemDescriptionTextView: UILabel!
    //    ItemDescriptionTextView
    @IBOutlet weak var PriceStaticLabel: UILabel!
    
    @IBOutlet weak var QuantityStaticLabel: UILabel!
    
    @IBOutlet weak var PriceValueLabel: UILabel!
    
    @IBOutlet weak var QuantityValueLabel: UILabel!
    
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
    
        self.contentView.layer.cornerRadius = 20
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        contentView.layer.masksToBounds = true
    
        
        }
    
    
}
