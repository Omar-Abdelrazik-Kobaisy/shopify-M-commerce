//
//  CoreDataManager.swift
//  E-commerce
//
//  Created by kariman eltawel on 08/03/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager
{
    static var context : NSManagedObjectContext?
    static var appDelegate : AppDelegate?
    
    
    static func saveToCoreData(productId : Int , productTitle: String , productImg : String , productprice:String )
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
        
        let entity = NSEntityDescription.entity(forEntityName: "Wishlist", in: myContext)
        
        guard let myEntity = entity else{return}
        
        do{
            
            
            let favorite_product = NSManagedObject(entity: myEntity, insertInto: myContext)
            
            
            favorite_product.setValue(productId, forKey: "product_id")
            favorite_product.setValue(productTitle, forKey: "product_title")
            favorite_product.setValue(productImg, forKey: "product_img")
            favorite_product.setValue(productprice, forKey: "product_price")
            print("Saved Successfully")
            
            
            try myContext.save()
            
        }catch let error{
            
            print(error.localizedDescription)
        }
    }
    
    static func deleteFromCoreData(productId :Int)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "Wishlist")
            let predictt = NSPredicate(format: "product_id == \(productId)")
            
            fetch.predicate = predictt
            
            let favProduct = try context?.fetch(fetch)
            
            guard let item = favProduct else {return}
            guard let itemFirst = item.first else {return}
            
             context?.delete(itemFirst)
            
            try context?.save()
            
            print("Deleted Succussfully")
            
        }catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    
    static func fetchFromCoreData() ->[FavoriteProduct]
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Wishlist")
        
        var arrayOfFavProd : [FavoriteProduct] = []
        
        do{
            
            
            
            let favProduct = try context?.fetch(fetch)
            
            guard let product = favProduct else{return []}
            
            for item in product
            {
                let producttitle = item.value(forKey: "product_title")
                let productimg = item.value(forKey: "product_img")
                let productid = item.value(forKey: "product_id")
                let productprice = item.value(forKey: "product_price")


                var products = FavoriteProduct(product_title: producttitle as! String,product_img: productimg as! String,product_id: productid as! Int,product_price: productprice as! String)
                
                arrayOfFavProd.append(products)
            }
            
        }catch let error
        {
            print(error.localizedDescription)
        }
        return arrayOfFavProd
    }

    
    
}
