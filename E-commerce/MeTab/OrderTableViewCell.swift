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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
