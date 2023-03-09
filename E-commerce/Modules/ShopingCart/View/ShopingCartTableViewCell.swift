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
    var itemCountInt : Int = 1
    var itemPriceIntValu :Int = 0
    var priceOfTotalItemCount : Int = 0
    let shopingCartViewObj = ShopingCartVC()
    
    @IBAction func decreaseItemCount(_ sender: Any) {
        
        ItemCount.text = String(itemCountInt)
        
        if itemCountInt == 1 {
            itemCountInt = 1
        }else{
            priceOfTotalItemCount -= itemPriceIntValu
            itemPrice.text = String(priceOfTotalItemCount)
            itemCountInt-=1
            ItemCount.text = String(itemCountInt)
        }
    }
    
    
    
    @IBAction func increaseItemCount(_ sender: Any) {
        if itemCountInt == 1{
            itemPriceIntValu = Int(itemPrice.text!)!
            priceOfTotalItemCount = Int(itemPrice.text!)!
        }
        priceOfTotalItemCount += itemPriceIntValu
        itemPrice.text = String(priceOfTotalItemCount)
        itemCountInt+=1
        ItemCount.text = String(itemCountInt)
     //   shopingCartViewObj.totalpriceOfItems += priceOfTotalItemCount
      //  shopingCartViewObj.updateTotalPrice(addedPrice: priceOfTotalItemCount)
       // shopingCartViewObj.tableViewOutlet.reloadData()
        shopingCartViewObj.addedPricetoInitialPOI = priceOfTotalItemCount
        shopingCartViewObj.updateTotalPrice(addedPrice: shopingCartViewObj.addedPricetoInitialPOI)
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
