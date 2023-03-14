//
//  AddressTableViewCell.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var Countrylbl: UILabel!
    @IBOutlet weak var Addresslbl: UILabel!
    @IBOutlet weak var phonelbl: UILabel!
    @IBOutlet weak var detailsOfCountrylbl: UILabel!
    @IBOutlet weak var detailsOfAddresslbl: UILabel!
    @IBOutlet weak var detailsOfPhonelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
            
        self.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        contentView.layer.masksToBounds = true
        
        }

}
