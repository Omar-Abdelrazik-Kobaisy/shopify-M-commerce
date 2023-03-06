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
    
    var couponArr :[coupon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bindingBrands = { [weak self] in
            self!.brands = self!.viewModel.ObservableBrands
            DispatchQueue.main.async{ [self] in
                self?.Brands_CollectionV.reloadData()
            }
        }
        viewModel.getAllBrands()
        couponArr = [coupon(img: UIImage(named: "c1")!, id: "70%") , coupon(img: UIImage(named: "c2")!, id: "80%") ,coupon(img: UIImage(named: "c1")!, id: "50%") ,coupon(img: UIImage(named: "c2")!, id: "40%")  ]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Ads_CollectionV
        {
            return couponArr!.count
        }
        return brands?.smart_collections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == Ads_CollectionV
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ad", for: indexPath) as! AdsCollectionViewCell
            
            
            cell.Ad_imageV.image = couponArr![indexPath.row].img
            
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
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
            
        
        if collectionView == Brands_CollectionV
        {
            let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
            
            productVC.brandId = brands?.smart_collections[indexPath.row].id
            productVC.brandTitle = brands?.smart_collections[indexPath.row].title
            
            productVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productVC, animated: true)
            
        }
        else
        {
            UIPasteboard.general.string = couponArr![indexPath.row].id
        }
    }
    
    @IBAction func cart(_ sender: Any) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
        
        navigationController?.pushViewController(cart, animated: true)
    }
    
    @IBAction func favourite(_ sender: Any) {
        let favouite = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController")as!WishListViewController
        
        navigationController?.pushViewController(favouite, animated: true)
    }
}
