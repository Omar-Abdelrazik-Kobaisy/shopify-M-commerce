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
    
    var itemQuantityIntValu  :Int = 0
    
    var priceOfTotalItemCount : Int = 0
    let shopingCartViewObj = ShopingCartVC()
    var temp :Int?
    var temprary : Int?
    var models : [OrderListModel]?
    var orderViewModel : OrderViewModel?
    
    var Mina: OrderListModel?
    
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
    
    //print(itemPrice.text)
    
    @IBAction func increaseItemCount(_ sender: Any) {
               itemCountInt+=1
               if Int(ItemCount.text ?? "") == 1{
                   itemPriceIntValu = temp ?? 0
                   
                   itemQuantityIntValu = temprary ?? 0
                   
                   priceOfTotalItemCount = temp ?? 0
               }
               priceOfTotalItemCount += itemPriceIntValu
               itemPrice.text = String(priceOfTotalItemCount)
        
                ItemCount.text =   String(itemQuantityIntValu)
        
              // ItemCount.text = String(itemCountInt)
        
            print("meeeeeeeen")
            print(temprary)
            print(temp)
            print(priceOfTotalItemCount)
        self.updateItem(item: Mina!, newPrice: String(priceOfTotalItemCount), NewQuantity: itemQuantityIntValu)
        
     //   shopingCartViewObj.totalpriceOfItems += priceOfTotalItemCount
      //  shopingCartViewObj.updateTotalPrice(addedPrice: priceOfTotalItemCount)
        
        //shopingCartViewObj.tableViewOutlet.reloadData()
        
        
        shopingCartViewObj.addedPricetoInitialPOI = priceOfTotalItemCount
        shopingCartViewObj.updateTotalPrice(addedPrice: shopingCartViewObj.addedPricetoInitialPOI)
        
    }
    
    func updateItem(item: OrderListModel, newPrice: String , NewQuantity: Int){
        item.itemPrice = newPrice
        item.itemQuantity = Int64(NewQuantity)
        print("itemUpdated")
        do{
            try context.save()
        }
        catch {
            
        }
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
