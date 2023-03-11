//
//  ShopingCartTableViewCell.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 01/03/2023.
//

import UIKit

class ShopingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemName : UILabel!
    @IBOutlet weak var itemPrice : UILabel!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var ItemCount : UILabel!
    
    var addQuantity : (()->())?
    var subQuantity : (()->())?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func decreaseItemCount(_ sender: Any) {
        subQuantity?()
    }

    @IBAction func increaseItemCount(_ sender: Any) {
        addQuantity?()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
