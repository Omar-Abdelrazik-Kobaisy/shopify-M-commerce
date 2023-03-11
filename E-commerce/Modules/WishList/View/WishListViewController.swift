//
//  WishListViewController.swift
//  E-commerce
//
//  Created by kariman eltawel on 06/03/2023.
//

import UIKit

class WishListViewController: UITableViewController {

    @IBOutlet var wishListTable: UITableView!
    var wishListArray :[FavoriteProduct] = []
    var viewmodel :WishListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        wishListTable.reloadData()
        viewmodel = WishListViewModel()
        
     
        wishListArray = (viewmodel?.getWishlist())!
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        wishListTable.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return wishListArray.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistCell", for: indexPath) as! WishListCell
        
        cell.productTitle.text = wishListArray[indexPath.row].product_title
        let url = URL(string: wishListArray[indexPath.row].product_img ?? "")
        cell.imageProduct?.kf.setImage(with: url)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(indexPath: indexPath)
        }

    }
    
    //------------function---------Alert------------------
    func showAlert(indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion ?", preferredStyle: .alert)
        
            //Delet-----From-------coredata------And--------UserDefaults
            alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
            print("ok clicked")
            guard let key = wishListArray[indexPath.row].product_id else
            { return  }
            print("\( wishListArray[indexPath.row].product_id ?? 0)")
            UserDefaults.standard.set(false, forKey: "\(key)")
            CoreDataManager.deleteFromCoreData(productId: wishListArray[indexPath.row].product_id ?? 0)
            print(wishListArray[indexPath.row].product_id!)
            wishListArray.remove(at: indexPath.row)
            wishListTable.deleteRows(at: [indexPath], with: .fade)
            wishListTable.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
        }))
        
        self.present(alert, animated: true) {
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetail = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as!ProductDetailsViewController
            productDetail.prodId = wishListArray[indexPath.row].product_id
        navigationController?.pushViewController(productDetail, animated: true)
    }

}
