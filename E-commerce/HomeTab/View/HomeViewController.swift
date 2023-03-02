//
//  HomeViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var Ads_CollectionV: UICollectionView!
    
    @IBOutlet weak var Brands_CollectionV: UICollectionView!
    
    var brands:Brands?
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getBrands()
        
        
        viewModel.bindingResultToHomeView = { [weak self] data in
            self?.brands = data
            DispatchQueue.main.async{ [self] in
                self?.Brands_CollectionV.reloadData()
            }
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Ads_CollectionV
        {
            return 5
        }
        return brands?.smart_collections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == Ads_CollectionV
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ad", for: indexPath) as! AdsCollectionViewCell
            
            
            cell.Ad_imageV.image = UIImage(named: "M")
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandsCollectionViewCell
        
        cell.Brand_imageV.kf.setImage(with: URL(string: brands?.smart_collections[indexPath.row].image.src ?? ""))
        cell.Brand_title.text = brands?.smart_collections[indexPath.row].title
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == Ads_CollectionV)
        {
            return CGSize(width:self.view.frame.width*0.9, height: self.view.frame.height*0.34)
        }
        
        return CGSize(width:self.view.frame.width*0.42, height: self.view.frame.height*0.24)
//        return CGSize()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == Brands_CollectionV
        {
            let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
            
            productVC.brandId = brands?.smart_collections[indexPath.row].id
            
            productVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productVC, animated: true)
            
        }
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
