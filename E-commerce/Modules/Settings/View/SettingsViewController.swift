//
//  SettingsViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit
import Reachability
import CoreData
import CoreMedia
class SettingsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    let reachability = try! Reachability()
    @IBOutlet weak var darkOutlet: UISwitch!
    let appDelegate = UIApplication.shared.windows.first
    var wishListArray :[FavoriteProduct] = []

    
    var SettingsArr = ["Address" , "Currency" , "About Us" , "Contact Us"]
    @objc func reachabilityChanged(note: Notification){
        let reachability = note.object as! Reachability
    }
    override func viewWillAppear( _ animated: Bool){
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.stopNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        
        if UserDefaults.standard.bool(forKey: "Dark"){
            darkOutlet.isOn = true
            appDelegate?.overrideUserInterfaceStyle = .dark

        }
        else{
            darkOutlet.isOn = false
            appDelegate?.overrideUserInterfaceStyle = .light

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image=UIImage(systemName: "homekit")
            cell.imageView?.tintColor = .label
            cell.textLabel?.text="Address"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.imageView?.image=UIImage(systemName: "dollarsign")
            cell.textLabel?.text="Currency"
            cell.imageView?.tintColor = .label
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.imageView?.image=UIImage(systemName: "info")
            cell.textLabel?.text="About"
            cell.imageView?.tintColor = .label
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.imageView?.image=UIImage(systemName: "contact.sensor")
            cell.textLabel?.text="Contact Us"
            cell.imageView?.tintColor = .label
            cell.accessoryType = .disclosureIndicator
            
        default:
            break
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch reachability.connection {
    case .wifi , .cellular:
        switch (indexPath.row){
        case 0 :
            if  UserDefaults.standard.integer(forKey:"loginid") == 0{
                            let unauth = self.storyboard?.instantiateViewController(withIdentifier: "UnauthUser")as!UnauthUser
                            
                            navigationController?.pushViewController(unauth, animated: true)
                            
                        }
                        else{
                            let addrVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
                            self.navigationController?.pushViewController(addrVC, animated: true)}
        case 1 :
             let alert = UIAlertController(title: "Currency", message: "Choose the currency", preferredStyle: .alert)
             
             
             alert.addAction(UIAlertAction(title: "EGP", style: .default ,handler: {  [weak self] _ in
                 UserDefaults.standard.set("EGP", forKey: "Currency")
             }))
            alert.addAction(UIAlertAction(title: "USD", style: .cancel ,handler: {  [weak self] _ in
                UserDefaults.standard.set("USD", forKey: "Currency")
            }))
             
             present(alert, animated: true)
        case 2 :
            let aboutVc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.present(aboutVc, animated: true)
        case 3 :
            let contactVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUs") as! ContactUs
            self.present(contactVC, animated: true)
            
        default:
            break
        }
        case .unavailable , .none :
                    let alert = UIAlertController(title: "No internet !" , message: "make sure of internet connection" ,preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok" , style: .default , handler: nil))
                    self.present(alert, animated: true )
                    self.tabBarController!.tabBar.isHidden = true
                    navigationController?.setNavigationBarHidden(true ,animated: false)
                }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        wishListArray = CoreDataManager.fetchFromCoreData()
        for item in wishListArray
        {
            CoreDataManager.deleteFromCoreData(productId: item.product_id ?? 0)
        }
        UserDefaults.standard.set(0, forKey: "loginid")
        UserDefaults.standard.set("", forKey: "loginfirstName")
        let logOut = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let navigationController = UINavigationController(rootViewController: logOut)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
//        self.tabBarController?.naviga tionItem.hidesBackButton = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        navigationController?.pushViewController(logOut, animated: true)
    }
    
    
    @IBAction func DarkModeAction(_ sender: UISwitch) {
        if #available(iOS 13, *){
            if sender.isOn{
                UserDefaults.standard.set(true, forKey: "Dark")
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            else{
                UserDefaults.standard.set(false, forKey: "Dark")
                appDelegate?.overrideUserInterfaceStyle = .light
            }
            
        }else{
            print("DarkMode is unAvailable")
        }
    }
    
}
