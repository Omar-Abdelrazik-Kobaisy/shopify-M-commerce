//
//  HomeViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit
import Kingfisher
import Reachability
//import BadgeSwift
class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var shoppingCartBtn: UIBarButtonItem!
    @IBOutlet weak var Ads_CollectionV: UICollectionView!
    @IBOutlet weak var Brands_CollectionV: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    var timer : Timer?
    var currentCellIndex = 0
    let reachability = try! Reachability()
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

    override func viewWillAppear( _ animated: Bool){
        let rightBarButton = self.navigationItem.rightBarButtonItem

        let cartItems = CartItems.sharedIstance
        let cartCount = cartItems.getAllCartItems().count
        rightBarButton?.addBadge(text: "\(cartCount)" , withOffset: CGPoint(x: -60, y: 0))
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.stopNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        reachability.stopNotifier()
        self.tabBarController?.navigationItem.hidesBackButton = true
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        switch reachability.connection {
        case .wifi , .cellular:
            navigationItem.hidesSearchBarWhenScrolling = false
            makeSearchBar()
            
            
            viewModel.bindingBrands = { [weak self] in
                self!.brands = self!.viewModel.ObservableBrands
                DispatchQueue.main.async{ [self] in
                    self?.Brands_CollectionV.reloadData()
                }
            }
            viewModel.getAllBrands()
            couponArr = [coupon(img: UIImage(named: "c1")!, id: "shopify5%") , coupon(img: UIImage(named: "c4")!, id: "shopify10%") ,coupon(img: UIImage(named: "c3")!, id: "shopify15%") ]
            
        case .unavailable , .none :
            let alert = UIAlertController(title: "No internet !" , message: "make sure of internet connection" ,preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok" , style: .default , handler: nil))
            self.present(alert, animated: true )
            self.tabBarController!.tabBar.isHidden = true
            navigationController?.setNavigationBarHidden(true ,animated: false)
        }
    }
    
    @objc func reachabilityChanged(note: Notification){
        let reachability = note.object as! Reachability
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    
    @objc func moveToNextIndex(){
        if currentCellIndex < couponArr!.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        Ads_CollectionV.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentCellIndex
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Ads_CollectionV
        {
            return couponArr?.count ?? 0
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
            AppSnackBar.make(in: self.view, message: "Congratulations! you get a coupon ", duration: .lengthLong).show()
        }
    }
    
    @IBAction func cart(_ sender: Any) {
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
            
            navigationController?.pushViewController(unauth, animated: true)
            
        }
        else{
                let cart = self.storyboard?.instantiateViewController(withIdentifier: "ShopingCartVC")as! ShopingCartVC
                
                navigationController?.pushViewController(cart, animated: true)
            
        }
    }
    
    @IBAction func favourite(_ sender: Any) {
        if  UserDefaults.standard.integer(forKey:"loginid") == 0{
            
            let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
            
            navigationController?.pushViewController(unauth, animated: true)
            
            
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

}


