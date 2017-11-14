//
//  ViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 9/30/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFImageHelper

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, DetailDelegate {

    @IBOutlet var collectionHeader: UICollectionView!
    @IBOutlet var mTableView: UITableView!
    @IBOutlet var btnOrder: UIButton!
    @IBOutlet weak var lbHeader: UILabel!
    
    let reuseIdentifier = "headerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lbHeader.text = "NEWPRODUCT".localized()
        //SVProgressHUD.setDefaultMaskType(.clear)
        MService.shared.getNewProducts { (listFoods) in
            if listFoods != nil {
                SData.shared.listNewProducts = listFoods
                self.collectionHeader.reloadData()
            }
            MService.shared.getCategories(completion: { (listCategory) in
                if listCategory != nil {
                    SData.shared.listCategories = listCategory!.group { $0.type_name }
                    self.mTableView.reloadData()
                }
            })
        }
        
        self.title = "Product".localized()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (SData.shared.listDetailId.count) > 0 {
            self.addBadgeIcon(num: (SData.shared.listDetailId.count))
        }
        else {
            if let badgeIco = self.btnOrder.viewWithTag(12) as? UILabel {
                badgeIco.removeFromSuperview()
            }
        }
    }
    
    func addBadgeIcon(num: Int) {
        let badgeIco = UILabel(frame: CGRect(x: btnOrder.frame.size.width - 30, y: -10, width: 20, height: 20))
        //badgeIco.layer.borderWidth = 1.0
        badgeIco.layer.cornerRadius = 10
        badgeIco.layer.masksToBounds = true
        //badgeIco.layer.borderColor = UIColor.red.cgColor
        badgeIco.text = "\(num)"
        badgeIco.font = UIFont.boldSystemFont(ofSize: 15)
        badgeIco.textColor = UIColor.white
        badgeIco.backgroundColor = UIColor.red
        badgeIco.textAlignment = NSTextAlignment.center
        badgeIco.tag = 12
        self.btnOrder.addSubview(badgeIco)
    }
    
    @IBAction func menuAction(_ sender: AnyObject) {
        self.openLeft()
    }
    
    @IBAction func cartAction(_ sender: AnyObject) {
        if (SData.shared.listDetailId.count) > 0 {
            self.performSegue(withIdentifier: "AddToCart", sender:nil)
        }
    }
    
    func selectedProduct(category: Category) {
        self.performSegue(withIdentifier: "Product", sender: category)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SData.shared.listNewProducts?.count ?? 0
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! HeaderViewCell
        let value = SData.shared.listNewProducts![indexPath.row] as Product
        let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(value.photo ?? "")".replacingOccurrences(of: " ", with: "%20")
        cell.imgProduct.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
            cell.imgProduct.image = nil
            cell.imgProduct.image = image
        }
        cell.lbPName.text = value.product_name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = SData.shared.listNewProducts![indexPath.row] as Product
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCartViewControllerId") as? AddCartViewController {
            viewController.product = value
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SData.shared.listCategories.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableCollectViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCollectViewCellId") as! TableCollectViewCell!
        cell.delegate = self
        
        let sectionName = Array(SData.shared.listCategories.keys)[indexPath.row]
        cell.lbTitle.text = sectionName
        cell.listItems = SData.shared.listCategories[sectionName]!
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Product" {
            let category: Category = sender as! Category
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.category = category
        }
        else if segue.identifier == "AddToCart" {
            let _:CheckoutViewController = segue.destination as! CheckoutViewController
            //detailVC.item = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

public extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}



