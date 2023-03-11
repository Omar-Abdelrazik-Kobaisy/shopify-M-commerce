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
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            alertForUser()
            
        }
        else{
            let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
            
            navigationController?.pushViewController(cart, animated: true)
            
        }
        
    }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            alertForUser()
            
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
            
            cell.favourite_btn.isSelected = !cell.favourite_btn.isSelected
            
            if cell.favourite_btn.isSelected {
                
                cell.favourite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                CoreDataManager.saveToCoreData(productId: products?.products[indexPath.row].id ?? 0, productTitle:products?.products[indexPath.row].title ?? "", productImg: products?.products[indexPath.row].image.src ?? "")
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

                
            }
            
        }
        
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
    func alertForUser(){
      let alert = UIAlertController(title: "Alert", message: "You need to login or signUp ", preferredStyle: .alert)
      
          //Delet-----From-------coredata------And--------UserDefaults
      alert.addAction(UIAlertAction(title: "Login", style: .default , handler: { [self] action in
                  let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                  navigationController?.pushViewController(login, animated: true)

      }))
      
      alert.addAction(UIAlertAction(title: "SignUp", style: UIAlertAction.Style.cancel , handler: { [self] action in
          
              let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
              navigationController?.pushViewController(signup, animated: true)
      }))
        
    alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.cancel ,handler:{_ in }))

      present(alert, animated: true)

      
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



