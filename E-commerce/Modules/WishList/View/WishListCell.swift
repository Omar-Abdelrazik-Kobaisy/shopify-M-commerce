//
//  WishListCell.swift
//  E-commerce
//
//  Created by kariman eltawel on 12/03/2023.
//

import UIKit

class WishListCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    


    @IBOutlet weak var imageProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
