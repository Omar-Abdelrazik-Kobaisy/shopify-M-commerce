//
//  ShopingCartTableViewCell.swift
//  E-commerce
//
//  Created by Ahmed Fekry on 01/03/2023.
//

import UIKit

protocol OnCellSelectDelegate : AnyObject
{
    func onSelect(price : String)
}

class ShopingCartTableViewCell: UITableViewCell {
       
    weak var onCellSelectDelegate : OnCellSelectDelegate? = nil
    
    @IBOutlet weak var itemName : UILabel!
    @IBOutlet weak var itemPrice : UILabel!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var ItemCount : UILabel!
    //--->
    var itemCountInt : Int = 1
    
    //--->
    var itemPriceIntValu :Int?
    
    var itemQuantityIntValu  :Int = 0
    
    //---->
    var totalNumber : Int = 0
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        itemPriceIntValu = ((itemPrice.text! as NSString).integerValue )
//        print(itemPriceIntValu)
    }
    
    var priceOfTotalItemCount : Int = 0
    let shopingCartViewObj = ShopingCartVC()
    var temp :Int?
    var temprary : Int?
//    var models : [OrderListModel]?
//    var orderViewModel : OrderViewModel?
    
    var Mina: OrderListModel?
    
    @IBAction func decreaseItemCount(_ sender: Any) {
        
//        ItemCount.text = String(itemCountInt)
//
//        if itemCountInt == 1 {
//            itemCountInt = 1
//        }else{
//            priceOfTotalItemCount -= itemPriceIntValu
//            itemPrice.text = String(priceOfTotalItemCount)
//            itemCountInt-=1
//            ItemCount.text = String(itemCountInt)
//        }
        
        if itemCountInt != 1
        {
            itemCountInt -= 1
        }
        else
        {
            return
        }
        ItemCount.text = String(itemCountInt)

        if itemCountInt == 1 {
            itemCountInt = 1
        }else{
            priceOfTotalItemCount -= itemPriceIntValu
            itemPrice.text = String(priceOfTotalItemCount)
            itemCountInt-=1
            ItemCount.text = String(itemCountInt)
        }
      //  self.updateItem(item: Mina!, newPrice: String(priceOfTotalItemCount), NewQuantity: itemCountInt)
    }
    
    
    
    @IBAction func increaseItemCount(_ sender: Any) {
               itemCountInt+=1
               if Int(ItemCount.text ?? "") == 1{
                   itemPriceIntValu = temp ?? 0
                   priceOfTotalItemCount = temp ?? 0
               }
               priceOfTotalItemCount += itemPriceIntValu
               itemPrice.text = String(priceOfTotalItemCount)
               ItemCount.text = String(itemCountInt)
        print("world")
        print(priceOfTotalItemCount)
        
//        print("neerwre")
//        print(temp)
        //self.updateItem(item: Mina!, NewQuantity: itemCountInt)
        
//        self.updateItem(item: Mina!, NewQuantity: itemCountInt)
//        self.updateItem(item: Mina!, NewQuantity: itemCountInt)
        /* newPrice: String(priceOfTotalItemCount),*/
        
     //   shopingCartViewObj.totalpriceOfItems += priceOfTotalItemCount
      //  shopingCartViewObj.updateTotalPrice(addedPrice: priceOfTotalItemCount)
        
        //shopingCartViewObj.tableViewOutlet.reloadData()
        
        
        
      //  shopingCartViewObj.addedPricetoInitialPOI = priceOfTotalItemCount
        shopingCartViewObj.updateTotalPrice(addedPrice: priceOfTotalItemCount)
        
    }
    
    func updateItem(item: OrderListModel,  NewQuantity: Int){
        //item.itemPrice = newPrice
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

    
    
//    func configureCell(order:OrderListModel){
//        let url = URL(string: order.itemImage!)
//        itemImage.kf.setImage(with: url)
//        itemName.text = order.itemName
//        itemPrice.text = order.itemPrice
////        print(itemPrice.text)
//        ItemCount.text = String(itemCountInt)
//        
//    }

}
