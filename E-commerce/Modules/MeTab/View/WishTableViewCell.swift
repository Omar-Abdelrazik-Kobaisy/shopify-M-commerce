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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
