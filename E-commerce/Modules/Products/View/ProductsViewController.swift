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
    
    var productsBrand : product?
    
    @IBOutlet weak var collection_V: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let id = brandId else {return}
        let PRODUCTS_BRAND_URL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/collections/\(id)/products.json"
        
        let PRODUCT_DETAILS_URL = ""
        
        ApiService.fetchFromApi(API_URL: PRODUCTS_BRAND_URL) {[weak self] data in
            self?.productsBrand = data
            DispatchQueue.main.async {
                self?.collection_V.reloadData()
            }
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsBrand?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
        
        cell.product_image.kf.setImage(with: URL(string: productsBrand?.products[indexPath.row].image.src ?? ""))
        cell.product_price.text = productsBrand?.products[indexPath.row].product_type
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:self.view.frame.width*0.25, height: self.view.frame.height*0.25)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
