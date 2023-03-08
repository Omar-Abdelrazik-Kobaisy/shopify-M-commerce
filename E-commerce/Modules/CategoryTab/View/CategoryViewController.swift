//
//  CategoryViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit
import Kingfisher
import Floaty

class CategoryViewController: UIViewController ,UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var category_segment: UISegmentedControl!
    
    @IBOutlet weak var productCollectionV: UICollectionView!
    
    var category : Category?
        
        var products : product?
        let floaty = Floaty()
        var arr_filtered : [productItem]!
        var arr_products : [productItem] = []
        var isFilterd : Bool = false
       var CatogoryFilter : [productItem] = []

        var arr_category_id : [Int] = []
    
    var viewModel = CategoryViewModel()
    
    
    
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool{
            return searchController.searchBar.text!.isEmpty
        }
    var isFiltering : Bool{
            return searchController.isActive && !isSearchBarEmpty
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        makeSearchBar()
        
        filterByFloatyButton()
        
        viewModel.getCategory()
        
        viewModel.bindingCategory = { [weak self] data in
            self?.category = data
        }
        
        viewModel.bindingCategoryId = { [weak self] data in
            self?.arr_category_id = data
            DispatchQueue.main.async {
                
                for i in 1..<(self?.category?.custom_collections.count ?? 0)
                {
                    self?.category_segment.setTitle(self?.category?.custom_collections[i].title, forSegmentAt: i-1)
                }
                self?.showProductByCategory((self?.category_segment)!)
            }
        }
    }
    
    fileprivate func showProductByCategory(_ sender: UISegmentedControl) {
           let url = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json?collection_id=\(arr_category_id[sender.selectedSegmentIndex])"
        viewModel.getProductsCategory(url: url)
        
        viewModel.bindingProductsCategory = {[weak self] data in
            self?.products = data
            DispatchQueue.main.async {
                self?.productCollectionV.reloadData()
            }
        }
       }
    
    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {
        showProductByCategory(sender)
               isFilterd = false
    }
    
    func filterByFloatyButton()
    {
        floaty.buttonColor = .systemBlue
               floaty.openAnimationType = .fade
               floaty.paddingX = 20
               floaty.paddingY = 100

               floaty.addItem("T-Shirt", icon: UIImage(systemName: "tshirt.fill")){_ in
                   let arr = self.products?.products.filter{
                       $0.product_type == "T-SHIRTS"
                   }
                   self.isFilterd = true
                   self.arr_filtered = arr
                   self.productCollectionV.reloadData()
               }
               floaty.addItem("Shoes", icon: UIImage(named: "shoes")){_ in
                   let arr = self.products?.products.filter{
                       $0.product_type == "SHOES"
                   }
                   self.isFilterd = true
                   self.arr_filtered = arr
                   self.productCollectionV.reloadData()
               }
               floaty.addItem("Accessory", icon: UIImage(named: "accessory")){_ in
                   let arr = self.products?.products.filter{
                       $0.product_type == "ACCESSORIES"
                   }
                   self.isFilterd = true
                   self.arr_filtered = arr
                   self.productCollectionV.reloadData()
               }
               
               view.addSubview(floaty)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFilterd
               {
                   return arr_filtered.count
               }
        else if isFiltering {
            return CatogoryFilter.count
        }
        return products?.products.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! CategoryCollectionViewCell
        if isFilterd
               {
                   cell.product_image.kf.setImage(with: URL(string: arr_filtered[indexPath.row].image.src ?? ""))
                   cell.product_name.text = arr_filtered[indexPath.row].variants[0].price
                   
                   return cell
               }
        else if isFiltering {

            cell.product_image.kf.setImage(with: URL(string: CatogoryFilter[indexPath.row].image.src ?? ""))
            cell.product_name.text = CatogoryFilter[indexPath.row].variants[0].price

            return cell
        }
               cell.product_image.kf.setImage(with: URL(string: products?.products[indexPath.row].image.src ?? ""))
               cell.product_name.text = products?.products[indexPath.row].variants[0].price
               
               
               return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:self.view.frame.width*0.43, height: self.view.frame.height*0.24)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetail = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as!ProductDetailsViewController
        
        if isFilterd{
            productDetail.prodId = arr_filtered[indexPath.row].id
        }
        else{
            
            productDetail.prodId = products?.products[indexPath.row].id
        }
       
        
        navigationController?.pushViewController(productDetail, animated: true)
    }
    
    @IBAction func cartButton(_ sender: Any) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
        
        navigationController?.pushViewController(cart, animated: true)
    }
    

    @IBAction func favoriteButton(_ sender: Any) {
        let favorite = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController")as! WishListViewController
        
        navigationController?.pushViewController(favorite, animated: true)
    }
    
    }

//------------------for-------------search-----------------
extension CategoryViewController: UISearchResultsUpdating, UISearchBarDelegate{

    func makeSearchBar(){

        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .black
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField

        textFieldInsideSearchBar?.textColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = false
                
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        CatogoryFilter = (products?.products)!.filter({ filter in
            return filter.title!.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        productCollectionV.reloadData()
    }
}



