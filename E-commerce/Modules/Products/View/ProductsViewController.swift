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
    
    @IBOutlet weak var max_price: UILabel!
    
    @IBOutlet weak var min_price: UILabel!
    
    @IBOutlet weak var filter_slider: UISlider!
    var productsBrand : product?
    
    
    var arr_product : [productItem] = []
        
    var arr_product_filtered : [productItem]!
    
    var productsViewModel  = ProductsViewModel()
    
    @IBOutlet weak var collection_V: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filter_slider.isHidden = true
        max_price.isHidden = true
        min_price.isHidden = true

        // Do any additional setup after loading the view.
               guard let id = brandId else {return}
                       
               let PRODUCTS_BRAND_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json?collection_id=\(id)"

               productsViewModel.getproductsBrand(PRODUCTS_BRAND_URL: PRODUCTS_BRAND_URL)
               
               productsViewModel.bindingproductsBrand = { [self] in
                   productsBrand = productsViewModel.ObservableproductsBrand
                   for i in 0..<(productsBrand?.products.count ?? 0)
                               {
                                   guard let item = productsViewModel.ObservableproductsBrand?.products[i] else {return}
                                   arr_product.append(item)
                               }
                               DispatchQueue.main.async {
                                   self.collection_V.reloadData()
                               }
               }
               
    }
    
    @IBAction func filter_btn(_ sender: Any) {
        filter_slider.isHidden = false
        max_price.isHidden = false
        min_price.isHidden = false
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        max_price.text = String(sender.value)+"$"
                let filter_arr = arr_product.filter{ Float($0.variants.first?.price ?? "0.0") ?? 0 <= sender.value}
                
                arr_product_filtered = filter_arr
                self.collection_V.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return productsBrand?.products.count ?? 0
        if filter_slider.isHidden
               {
                   return arr_product.count
               }
               return arr_product_filtered.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
            if filter_slider.isHidden
                    {
                        cell.product_image.kf.setImage(with: URL(string: arr_product[indexPath.row].image.src ?? ""))
                        cell.product_price.text = arr_product[indexPath.row].variants.first?.price
                        return cell
                    }
                        cell.product_image.kf.setImage(with: URL(string: arr_product_filtered[indexPath.row].image.src ?? ""))
                        cell.product_price.text = arr_product_filtered[indexPath.row].variants.first?.price
                        return cell
        }
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width:self.view.frame.width*0.25, height: self.view.frame.height*0.25)
        }

  

}
