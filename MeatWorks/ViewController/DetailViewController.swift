//
//  DetailViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/7/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionHeader: UICollectionView!
    @IBOutlet var collectionView: UICollectionView!
    
    var category: Category?
    var listCategoryFilter: [Category]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.slideMenuController()?.removeLeftGestures()
        self.title = self.category?.type_name
        
        let sectionName = self.category?.type_name ?? ""
        self.listCategoryFilter = SData.shared.listCategories[sectionName]!
        
        MService.shared.getListProduct(categoryId: (self.category?.product_id)!) { (listProducts) in
            if listProducts != nil {
                SData.shared.listProducts = listProducts!
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func backAction(_ sender: AnyObject) {
        self.slideMenuController()?.addLeftGestures()
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader {
            let itemFilter = (self.listCategoryFilter?[indexPath.row].product_name ?? "")
            let size: CGSize = itemFilter.size(attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 20.0) as Any])
            return CGSize(width: size.width + 10.0, height: 40)
        }
        else {
            return CGSize(width: (collectionView.frame.size.width - 10) / 2, height: 250)
        }
    }
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionHeader {
            return self.listCategoryFilter?.count ?? 0
        }
        else {
            return SData.shared.listProducts.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailHdCollectionCellId", for: indexPath as IndexPath) as! DetailHdCollectionCell
            cell.layer.cornerRadius = 20.0
            cell.lbTitle.text = self.listCategoryFilter?[indexPath.row].product_name
            if self.category?.product_name == self.listCategoryFilter?[indexPath.row].product_name {
                cell.isSelected = true
            }
            else {
                cell.isSelected = false
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCellId", for: indexPath as IndexPath) as! DetailCollectionCell
            cell.layer.cornerRadius = 5.0
            let value = SData.shared.listProducts[indexPath.row]
            cell.lbPrice.text = (value.unit_price ?? "") + (value.currency_id ?? "") + "/" + (value.unit_name ?? "")
            let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(value.photo ?? "")".replacingOccurrences(of: " ", with: "%20")
            cell.imgView.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
                //cell.imgView.image = image
            }
            cell.lbTitle.text = value.product_name ?? ""
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let value: Product = SData.shared.listProducts[indexPath.row] as Product
            self.performSegue(withIdentifier: "FoodDetail", sender:value)
        }
        else {
            let category = self.listCategoryFilter?[indexPath.row]
            MService.shared.getListProduct(categoryId: category?.product_id ?? "") { (listProducts) in
                if listProducts != nil {
                    SData.shared.listProducts = listProducts!
                    self.collectionView.reloadData()
                }
            }
            self.category = category
            self.collectionHeader.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodDetail" {
            let product:Product = sender as! Product
            let detailVC:AddCartViewController = segue.destination as! AddCartViewController
            detailVC.product = product
            //detailVC.item = ""
        }
    }

}
