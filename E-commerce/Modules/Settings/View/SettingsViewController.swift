//
//  SettingsViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit

class SettingsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var SettingsArr = ["Address" , "Currency" , "About Us" , "Contact Us"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func LogOutBtnClicked(_ sender: Any) {
        
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
        switch (indexPath.row){
        case 0 :
            let addrVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
            self.navigationController?.pushViewController(addrVC, animated: true)
        case 1 :
            print("one")
        case 2 :
            let aboutVc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.present(aboutVc, animated: true)
        case 3 :
            let contactVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUs") as! ContactUs
            self.present(contactVC, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        UserDefaults.standard.set(0, forKey: "loginid")
        let userDefultId =  UserDefaults.standard.integer(forKey:"loginid")
        print("JSON STRING IS", userDefultId ?? 0)
        let logOut = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(logOut, animated: true)
    }
    
    
    @IBAction func DarkModeAction(_ sender: UISwitch) {
        if #available(iOS 13, *){
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn{
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            else{
                appDelegate?.overrideUserInterfaceStyle = .light
            }
            
        }else{
            print("DarkMode is unAvailable")
        }
    }
    
}
