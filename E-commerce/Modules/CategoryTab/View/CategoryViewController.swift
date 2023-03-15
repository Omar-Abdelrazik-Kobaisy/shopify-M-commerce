//
//  CategoryViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit
import Kingfisher
import Floaty

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var ShoppingCartBtn: UIBarButtonItem!
    
    @IBOutlet weak var category_segment: UISegmentedControl!
    
    @IBOutlet weak var productCollectionV: UICollectionView!
    
    var category : Category?
    var favId = ""
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
    
    override func viewWillAppear(_ animated: Bool) {
        productCollectionV.reloadData()
        let rightBarButton = self.navigationItem.rightBarButtonItem

        let cartItems = CartItems.sharedIstance
        let cartCount = cartItems.getAllCartItems().count
        rightBarButton?.addBadge(text: "\(cartCount)" , withOffset: CGPoint(x: -60, y: 0))
    }
    
    fileprivate func showProductByCategory(_ sender: UISegmentedControl) {
        let url = "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/products.json?collection_id=\(arr_category_id[sender.selectedSegmentIndex])"
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
        floaty.buttonColor = .orange
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:self.view.frame.width*0.43, height: self.view.frame.height*0.35)
        
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
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
            
            navigationController?.pushViewController(unauth, animated: true)
        }
        else{
            let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
            
            navigationController?.pushViewController(cart, animated: true)
            
        }
        
    }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
            
            navigationController?.pushViewController(unauth, animated: true)
        }
        else{
            let favouite = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController")as!WishListViewController
            
            navigationController?.pushViewController(favouite, animated: true)
        }
        
    }
    
}


extension CategoryViewController:UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! CategoryCollectionViewCell
        
        //---------check--------button---------state
        favId = "\(products?.products[indexPath.row].id ?? 0)"
//        cell.favourite_btn.isSelected = UserDefaults.standard.bool(forKey: self.favId)
        print(UserDefaults.standard.bool(forKey: self.favId))
        if UserDefaults.standard.bool(forKey: self.favId){
            cell.favourite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        }else{
            cell.favourite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.favourite_btn.isSelected = UserDefaults.standard.bool(forKey: self.favId)

        cell.favProd = { [unowned self] in
            if  UserDefaults.standard.integer(forKey:"loginid") == 0{
                
                
                let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
                
                navigationController?.pushViewController(unauth, animated: true)}
            else{
                cell.favourite_btn.isSelected = !cell.favourite_btn.isSelected
                
                if cell.favourite_btn.isSelected {
                    
                    cell.favourite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    CoreDataManager.saveToCoreData(productId: products?.products[indexPath.row].id ?? 0, productTitle:products?.products[indexPath.row].title ?? "", productImg: products?.products[indexPath.row].image.src ?? "",productprice: products?.products[indexPath.row].variants[0].price ?? "")
                    UserDefaults.standard.set(true, forKey: "\(products?.products[indexPath.row].id  ?? 0)")
                    print("selected")
                    print(products?.products[indexPath.row].id ?? 0)
                    
                    
                }
                else{
                    //---------------un----------selected(deletion)-----------------
                    cell.favourite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
                    print("unselected")
                    print(products?.products[indexPath.row].id ?? 0)
                    CoreDataManager.deleteFromCoreData(productId: products?.products[indexPath.row].id ?? 0)
                    UserDefaults.standard.set(false, forKey: "\(products?.products[indexPath.row].id  ?? 0)")
                    
                    
                }}
            
        }
        
        if isFilterd
               {
                   cell.product_image.kf.setImage(with: URL(string: arr_filtered[indexPath.row].image.src ?? ""))
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                cell.product_price.text = (arr_filtered[indexPath.row].variants[0].price ?? "") + " EGP"
            }else{
                cell.product_price.text = (arr_filtered[indexPath.row].variants[0].price ?? "") + " USD"
            }
            cell.product_name.text = arr_filtered[indexPath.row].title
                   return cell
               }
        else if isFiltering {

            cell.product_image.kf.setImage(with: URL(string: CatogoryFilter[indexPath.row].image.src ?? ""))
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                cell.product_price.text = (CatogoryFilter[indexPath.row].variants[0].price ?? "") + " EGP"
            }else{
                cell.product_price.text = (CatogoryFilter[indexPath.row].variants[0].price ?? "") + " USD"
            }

            cell.product_name.text = CatogoryFilter[indexPath.row].title
            return cell
        }
               cell.product_image.kf.setImage(with: URL(string: products?.products[indexPath.row].image.src ?? ""))
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            cell.product_price.text = (products?.products[indexPath.row].variants[0].price ?? "") + " EGP"
        }else{
            cell.product_price.text = (products?.products[indexPath.row].variants[0].price ?? "") + " USD"
        }
               
        cell.product_name.text = products?.products[indexPath.row].title
               return cell
        
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



