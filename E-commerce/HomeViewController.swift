//
//  HomeViewController.swift
//  E-commerce
//
//  Created by Omar on 01/03/2023.
//

import UIKit

class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var Ads_CollectionV: UICollectionView!
    
    @IBOutlet weak var Brands_CollectionV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Ads_CollectionV
        {
            return 5
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == Ads_CollectionV
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ad", for: indexPath) as! AdsCollectionViewCell
            
            
            cell.Ad_imageV.image = UIImage(named: "M")
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandsCollectionViewCell
        
        cell.Brand_imageV.image = UIImage(named: "H")
        cell.Brand_title.text = "BrandTitle"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == Ads_CollectionV)
        {
            return CGSize(width:self.view.frame.width*0.9, height: self.view.frame.height*0.34)
        }
        
        return CGSize(width:self.view.frame.width*0.39, height: self.view.frame.height*0.24)
//        return CGSize()
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
