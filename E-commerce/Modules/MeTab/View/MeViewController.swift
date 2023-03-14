//
//  MeViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var OrderImg: UIImageView!
    
    @IBOutlet weak var wishimg: UIImageView!
    @IBOutlet weak var Orderslbl: UILabel!
    @IBOutlet weak var Wishlbl: UILabel!
    @IBOutlet weak var Order_TableV: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Wish_TableV: UITableView!
    
    var orders : GetOrder?
    var wishlistArr:[FavoriteProduct] = []
    var viewModel = MeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        wishlistArr = viewModel.getWishlist()
        if (wishlistArr.count == 0 ){
            Wish_TableV.isHidden = true
        }
        check()
        checkWishList()
        print(wishlistArr.count)
    }
    func check(){
        if orders?.orders.count == 0 {
            Order_TableV.isHidden = true
            Orderslbl.isHidden = true
            OrderImg.isHidden = false
            
        } else {
            Order_TableV.isHidden = false
            Orderslbl.isHidden = false
            OrderImg.isHidden = true
        }
    }
    func checkWishList(){
        if wishlistArr.count == 0 {
            Wish_TableV.isHidden = true
            wishimg.isHidden = false
        } else {
            Wish_TableV.isHidden = false
            wishimg.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefaults.standard.string(forKey:"loginfirstName"))
               let url = "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/customers/\(UserDefaults.standard.integer(forKey:"loginid"))/orders.json"
               
        
        viewModel.getOrders(url: url)
        
        viewModel.bindingResultToMeTab = {[weak self] data in
            self?.orders = data
            DispatchQueue.main.async {
                self?.Order_TableV.reloadData()
            }
        }
        if UserDefaults.standard.integer(forKey:"loginid") == 0{
            
            userName.text = "User"
            Wish_TableV.isHidden = true

        }
        
        else{
            userName.text = UserDefaults.standard.string(forKey:"loginfirstName")
        }
        Wish_TableV.reloadData()

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Order_TableV
        {
            return orders?.orders.count ?? 0
        }
        if wishlistArr.count == 1 {
            return 1
        }
        else if wishlistArr.count == 0 {
            return 0
        }
        else{
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Order_TableV
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderTableViewCell
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                cell.order_price.text = (orders?.orders[indexPath.row].total_price ?? "") + " EGP"
            }
            else{
                cell.order_price.text = (orders?.orders[indexPath.row].total_price ?? "") + " USD"
            }
            cell.order_createdat.text = orders?.orders[indexPath.row].created_at
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "wish", for: indexPath) as! WishTableViewCell
        
        let url = URL(string: wishlistArr[indexPath.row].product_img ?? "")
        cell.wish_image?.kf.setImage(with: url)
        cell.label_wish.text = wishlistArr[indexPath.row].product_title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    @IBAction func settingButton(_ sender: Any) {
        let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        navigationController?.pushViewController(setting, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == Order_TableV{
            let orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
            
            orderDetailsVC.created_at = orders?.orders[indexPath.row].created_at
            orderDetailsVC.user_name = (orders?.orders[indexPath.row].customer.first_name ?? "") + " " + (orders?.orders[indexPath.row].customer.last_name ?? "")
            
            orderDetailsVC.arr_of_orders = orders?.orders[indexPath.row].line_items
            
            
            self.navigationController?.pushViewController(orderDetailsVC, animated: true)}
        else{
            let productDetail = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as!ProductDetailsViewController
                productDetail.prodId =  wishlistArr[indexPath.row].product_id
            navigationController?.pushViewController(productDetail, animated: true)
            
        }
        

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

