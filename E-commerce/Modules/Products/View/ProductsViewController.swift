//
//  ProductsViewController.swift
//  E-commerce
//
//  Created by Omar on 02/03/2023.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var brandId : Int?
    var favId = ""
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
                       
               let PRODUCTS_BRAND_URL = "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/products.json?collection_id=\(id)"
        
//        "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json?collection_id=\(id)"

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
    
    override func viewWillAppear(_ animated: Bool) {
        collection_V.reloadData()
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
        if filter_slider.isHidden
               {
                   return arr_product.count
               }
               return arr_product_filtered.count
        }
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width:self.view.frame.width*0.25, height: self.view.frame.height*0.25)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetail = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as!ProductDetailsViewController
        if filter_slider.isHidden{
            productDetail.prodId = arr_product[indexPath.row].id
        }
        else{
            
            productDetail.prodId = arr_product_filtered[indexPath.row].id
        }
       
        
        navigationController?.pushViewController(productDetail, animated: true)
    }
    
    
  

}
extension ProductsViewController:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
//        cell.product_fav.isSelected = UserDefaults.standard.bool(forKey: self.favId)
        favId = "\(arr_product[indexPath.row].id ?? 0)"
        print("abovefavkey "+favId)
        if UserDefaults.standard.bool(forKey: self.favId){
            cell.product_fav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("fsavedavkey "+favId)
            print("add fav")

        }else{
            cell.product_fav.setImage(UIImage(systemName: "heart"), for: .normal)
            print("notsavedvedfavkey "+favId)
            print("not fav")
        }
        cell.product_fav.isSelected = UserDefaults.standard.bool(forKey: self.favId)
        cell.favProd = { [unowned self] in
            cell.product_fav.isSelected = !cell.product_fav.isSelected
            
            if cell.product_fav.isSelected {
                
                cell.product_fav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                CoreDataManager.saveToCoreData(productId: self.arr_product[indexPath.row].id ?? 0, productTitle: self.arr_product[indexPath.row].title ?? "", productImg: self.arr_product[indexPath.row].image.src ?? "")
                   UserDefaults.standard.set(true, forKey: "\(arr_product[indexPath.row].id  ?? 0)")

            }else{
                cell.product_fav.setImage(UIImage(systemName: "heart"), for: .normal)
                CoreDataManager.deleteFromCoreData(productId:  self.arr_product[indexPath.row].id ?? 0)
                UserDefaults.standard.set(false, forKey: "\(arr_product[indexPath.row].id  ?? 0)")

                
            }
            
        }
        
        
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
    
}
