//
//  SettingsViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit

class SettingsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

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
        
        cell.textLabel?.text = "address"
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row){
        case 0 :
            print("one")
        case 1 :
            print("one")
        case 2 :
            print("one")
        case 3 :
            print("one")
        default:
            break
        }
    }
    
   

}
