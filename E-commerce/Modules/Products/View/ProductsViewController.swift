//
//  ProductsViewController.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var brandId : Int?
    
    var brandTitle : String?
    
    var productsBrand : product?
    
    var product : Products?
    
    var arr_prices : [String] = []
    
    var productsViewModel  = ProductsViewModel()
    
    @IBOutlet weak var collection_V: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
               guard let id = brandId else {return}
                       
               let PRODUCTS_BRAND_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/collections/\(id)/products.json"

               productsViewModel.getproductsBrand(PRODUCTS_BRAND_URL: PRODUCTS_BRAND_URL)
               
               productsViewModel.bindingproductsBrand = { [self] in
                   productsBrand = productsViewModel.ObservableproductsBrand
               }
               
               
               let PRODUCT_DETAILS_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json"
               
               productsViewModel.getproduct(PRODUCT_DETAILS_URL: PRODUCT_DETAILS_URL)
               
               productsViewModel.bindingproduct = { [self] in
                   product = productsViewModel.Observableproduct
                   DispatchQueue.main.async() {
                       for i in 0..<(self.product?.products.count ?? 0)
                       {
                           if self.product?.products[i].vendor == self.brandTitle {
                               self.arr_prices.append(self.product?.products[i].variants[0].price ?? "")
                           }
                       }
                       self.collection_V.reloadData()
                   }
               }

    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productsBrand?.products.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
            cell.product_image.kf.setImage(with: URL(string: productsBrand?.products[indexPath.row].image.src ?? ""))
            cell.product_price.text = arr_prices[indexPath.row]
            return cell
        }
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width:self.view.frame.width*0.25, height: self.view.frame.height*0.25)
        }

  

}
