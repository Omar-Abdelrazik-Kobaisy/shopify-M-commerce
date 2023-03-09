//
//  ProductDetailsViewController.swift
//  E-commerce
//
//  Created by kariman eltawel on 02/03/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController,UICollectionViewDelegate {
    
    @IBOutlet weak var imageSlider: UIPageControl!
    @IBOutlet weak var ProductImagesCollection: UICollectionView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var ProductDescription: UILabel!
    
    let orderViewModel = OrderViewModel()
    var ProductViewModel:ProductDetailViewModel?
    var productInfo:ProductDetails?
    var prodId:Int?
    var currentpagee = 0
    var productt : productItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductViewModel = ProductDetailViewModel()
        ProductViewModel?.bindingProduct={ [weak self] in
            self?.productInfo = self?.ProductViewModel?.ObservableProduct
            
            DispatchQueue.main.async {
                self?.productt = self?.productInfo?.product
                self?.ProductName.text = self?.productInfo?.product.title
                self?.productPrice.text = self?.productInfo?.product.variants[0].price
                self?.ProductDescription.text = self?.productInfo?.product.body_html
                self?.imageSlider.numberOfPages = self?.productInfo?.product.images.count ?? 0
                
                self?.ProductImagesCollection.reloadData()
            }
        }
        imageSlider.currentPage = currentpagee
        ProductViewModel?.getProductDetails(productId:prodId ?? 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentpagee = Int(scrollView.contentOffset.x / width)
        imageSlider.currentPage = currentpagee
    }
    
    @IBAction func AddToCartBtnClicked(_ sender: Any) {
        orderViewModel.creatItem(product: productt!)
    }
}
    
    extension ProductDetailsViewController:UICollectionViewDataSource{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productInfo?.product.images.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsItem", for: indexPath) as! ProductDetailsCellViewController
            cell.imageProduct.kf.setImage(with: URL(string: productInfo?.product.images[indexPath.row].src ?? ""))
            return cell
        }
    }
 
    extension ProductDetailsViewController:UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    }

