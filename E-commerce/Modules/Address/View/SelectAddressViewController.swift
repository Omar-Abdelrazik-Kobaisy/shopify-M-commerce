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
    var statusCode : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //checkCartIsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
         noaddresslbl.isHidden = false
         
     } else {
     tableView.isHidden = false
     Selectedlbl.isHidden = false
     noaddresslbl.isHidden = true
     }
 }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerAddressTable?.addresses?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = customerAddressTable?.addresses![indexPath.row].address1
        cell.detailTextLabel?.text = customerAddressTable?.addresses![indexPath.row].phone
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        let payementVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        
        UserDefaults.standard.set(customerAddressTable?.addresses![indexPath.row].address1, forKey: "address")

        ApiService.updateAddress(customer_id: UserDefaults.standard.integer(forKey:"loginid")
                                 , address_id: customerAddressTable?.addresses?[indexPath.row].id ?? 0
                                 , address: customerAddressTable?.addresses?[indexPath.row].address1 ?? "") { [weak self] code in
            self?.statusCode = code
            print(self?.statusCode ?? 0)
            if self?.statusCode == 200 {
                print("updated successfully")
            }else{
                print(self?.statusCode?.description ?? "")
            }
        }
        
        
        self.navigationController?.pushViewController(payementVC, animated: true)
    
    }
    
    @IBAction func AddBtnClicked(_ sender: Any) {
        
        let addresVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        //self.present(addressVC, animated: true)
        self.navigationController?.pushViewController(addresVC, animated: true)
    }
    
    
    

}
