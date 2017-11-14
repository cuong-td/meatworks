//
//  DetailHdCollectionCell.swift
//  MeatWorks
//
//  Created by fwThanh on 10/7/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class DetailHdCollectionCell: UICollectionViewCell {
    @IBOutlet var lbTitle: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.white
                lbTitle.textColor = UIColor(hexString: "#4E549D")
                self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor(hexString: "#4E549D").cgColor
            } else {
                self.backgroundColor = UIColor(hexString: "#4E549D")
                lbTitle.textColor = UIColor.white
                self.layer.borderWidth = 0.0
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
}
