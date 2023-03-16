//
//  OrdersTableViewCell.swift
//  E-commerce
//
//  Created by Omar on 16/03/2023.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var order_price: UILabel!
    
    
    @IBOutlet weak var order_createdat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.layer.masksToBounds = true
        
        }


}
