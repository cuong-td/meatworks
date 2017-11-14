//
//  TableCollectViewCell.swift
//  MeatWorks
//
//  Created by fwThanh on 10/7/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

protocol DetailDelegate {
    func selectedProduct(category: Category)
}

class TableCollectViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var headerView: UIView!
    
    var delegate:DetailDelegate?
    var listItems = [Category]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerView.layer.cornerRadius = 5.0
        collectionView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listItems.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodViewCellId", for: indexPath as IndexPath) as! FoodViewCell
        cell.layer.cornerRadius = 5.0
        cell.lbTitle.text = self.listItems[indexPath.row].product_name
        let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(self.listItems[indexPath.row].photo )".replacingOccurrences(of: " ", with: "%20")
        cell.imgView.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
            cell.imgView.image = nil
            cell.imgView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedProduct(category: self.listItems[indexPath.row])
    }
}
