//
//  OrderDetialsTableViewCell.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 02/03/2023.
//

import UIKit

class OrderDetialsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ItemDescriptionTextView: UITextView!
    
    @IBOutlet weak var PriceStaticLabel: UILabel!
    
    @IBOutlet weak var QuantityStaticLabel: UILabel!
    
    @IBOutlet weak var PriceValueLabel: UILabel!
    
    @IBOutlet weak var QuantityValueLabel: UILabel!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
