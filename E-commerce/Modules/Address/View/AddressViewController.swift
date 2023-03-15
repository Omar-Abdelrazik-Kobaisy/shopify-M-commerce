//
//  AddressViewController.swift
//  E-commerce
//
//  Created by Mina on 01/03/2023.
//

import UIKit

class AddressViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartImg: UIImageView!
    
    var customerAddressTable : CustomerAddress?
    var GetModel : gettingViewModel?
    var statusCode : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        GetModel = gettingViewModel()

        check()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("\n\nwill Appear \n\n")
        GetModel?.getAddress()
        GetModel?.bindingGet = { [weak self] in
            DispatchQueue.main.async {
                self!.customerAddressTable = self!.GetModel?.ObservableGet
                self!.tableView.reloadData()
            }
        }
    }

    
    @IBAction func AddBtnClicked(_ sender: Any) {
        let addressVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController

        self.navigationController?.pushViewController(addressVC, animated: true)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerAddressTable?.addresses?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
        cell.detailsOfCountrylbl.text = customerAddressTable?.addresses![indexPath.row].country
        cell.detailsOfAddresslbl.text = customerAddressTable?.addresses![indexPath.row].address1
        cell.detailsOfPhonelbl.text = customerAddressTable?.addresses![indexPath.row].phone
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func editBtn()
    {
        AddBtn.backgroundColor = .clear
        AddBtn.layer.cornerRadius = 5
        AddBtn.layer.borderWidth = 1
        AddBtn.layer.borderColor = UIColor.tintColor.cgColor
    }
    func check(){
        if customerAddressTable?.addresses?.count == 0 {
            tableView.isHidden = true
            cartImg.isHidden = false
        }else {
            tableView.isHidden = false
            cartImg.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, _, handler in
            let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
                GetModel?.deleteAddress(AddressId: customerAddressTable?.addresses?[indexPath.row].id ?? 0
                                        , CustomerId:  UserDefaults.standard.integer(forKey:"loginid"))
                GetModel?.bindingStatusCode = { [weak self] code in
                    self?.statusCode = code
                    if self?.statusCode == 200{
                        print("delete successfully")
                    }else{
                        print(self?.statusCode?.description ?? "")
                    }
                }

                self.customerAddressTable?.addresses?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel ))
            self.present(alert, animated: true)
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, _, handler in
            guard let self = self else {return}
            self.editAddress(indexPath: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    func editAddress(indexPath:IndexPath) {
        let addressVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        addressVC.isEdit = true
        addressVC.phone = customerAddressTable?.addresses?[indexPath.row].phone
        addressVC.streetName = customerAddressTable?.addresses?[indexPath.row].address1
        addressVC.cityName = customerAddressTable?.addresses?[indexPath.row].city
        addressVC.country = customerAddressTable?.addresses?[indexPath.row].country
        addressVC.addressID = customerAddressTable?.addresses?[indexPath.row].id
        navigationController?.pushViewController(addressVC, animated: true)
    }
 
}
