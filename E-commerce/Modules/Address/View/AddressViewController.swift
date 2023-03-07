//
//  AddressViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit

class AddressViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func AddnewAddressBtn(_ sender: Any) {
        let addressVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
        cell.Countrylbl.text = "Egypt"
        cell.Addresslbl.text = "Helwan"
        cell.phonelbl.text = "012"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
