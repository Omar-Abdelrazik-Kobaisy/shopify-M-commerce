//
//  SelectAddressViewController.swift
//  E-commerce
//
//  Created by Mina on 10/03/2023.
//

import UIKit

class SelectAddressViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Selectedlbl: UILabel!
    @IBOutlet weak var noaddresslbl: UILabel!
    
   
    
    var GetModel : gettingViewModel?
    var customerAddressTable : CustomerAddress?
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCartIsEmpty()
        GetModel = gettingViewModel()
        GetModel?.getAddress()
        GetModel?.bindingGet = { [weak self] in
            DispatchQueue.main.async {
                self!.customerAddressTable = self!.GetModel?.ObservableGet
                self!.tableView.reloadData()
            }
        }
    }
    
    func checkCartIsEmpty() {
     if customerAddressTable?.addresses?.count == 0{
         tableView.isHidden = true
         Selectedlbl.isHidden = true
         
     } else {
     noaddresslbl.isHidden = true
     }
 }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerAddressTable?.addresses?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = customerAddressTable?.addresses![indexPath.row].address1
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        let payementVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        
    
        switch(indexPath.row){
        case 0 :
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(payementVC, animated: true)
        case 1 :
            self.showAlert(title: "Address not Selected", message: "Please Select the address")
            
        default:
            break
        }

    
    }
    func showAlert(title: String , message: String){
        let alert = UIAlertController(title: title ,message : message
                                      , preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(OkAction)
        self.present(alert, animated: true)
    }
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
