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
    var brandFilter : [BrandItem] = []

    
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool{
            return searchController.searchBar.text!.isEmpty
        }
    var isFiltering : Bool{
            return searchController.isActive && !isSearchBarEmpty
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesSearchBarWhenScrolling = false
        makeSearchBar()
        

        viewModel.bindingBrands = { [weak self] in
            self!.brands = self!.viewModel.ObservableBrands
            DispatchQueue.main.async{ [self] in
                self?.Brands_CollectionV.reloadData()
            }
        }
        viewModel.getAllBrands()
        couponArr = [coupon(img: UIImage(named: "c1")!, id: "shopify5%") , coupon(img: UIImage(named: "c2")!, id: "shopify10%") ,coupon(img: UIImage(named: "c1")!, id: "shopify15%") ]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Ads_CollectionV
        {
            return couponArr!.count
        }
        //----------search-----------array---------filtered---------------
        else if isFiltering {
            return brandFilter.count
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
        //----------search-----------array---------filtered---------------
        else if isFiltering {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandsCollectionViewCell
            
            cell.Brand_imageV.kf.setImage(with: URL(string: brandFilter[indexPath.row].image.src ?? ""))
            cell.Brand_title.text = brandFilter[indexPath.row].title

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
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
              alertForUser()
            
        }
        else{
                let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
                
                navigationController?.pushViewController(cart, animated: true)
            
        }
    }
    
    @IBAction func favourite(_ sender: Any) {
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            alertForUser()
            
        }
        else{
                let favouite = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController")as!WishListViewController
                
                navigationController?.pushViewController(favouite, animated: true)
        }}
    
}
//------------------for-------------search-----------------
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate{

    func makeSearchBar(){

            searchController.searchResultsUpdater = self
            searchController.searchBar.tintColor = .black
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search for Brand"
            let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField

            textFieldInsideSearchBar?.textColor = .black
            navigationItem.searchController = searchController
            definesPresentationContext = false
                
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            brandFilter = (brands?.smart_collections)!.filter({ filter in
                return filter.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        Brands_CollectionV.reloadData()
    }
    
      func alertForUser(){
        let alert = UIAlertController(title: "Alert", message: "You need to login or signUp ", preferredStyle: .alert)
        
            //Delet-----From-------coredata------And--------UserDefaults
        alert.addAction(UIAlertAction(title: "Login", style: .default , handler: { [self] action in
                    let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                    navigationController?.pushViewController(login, animated: true)

        }))
        
        alert.addAction(UIAlertAction(title: "SignUp", style: UIAlertAction.Style.default , handler: { [self] action in
            
                let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
                navigationController?.pushViewController(signup, animated: true)
        }))
          
     alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.cancel ,handler:{_ in }))

        present(alert, animated: true)

        
    }

}


