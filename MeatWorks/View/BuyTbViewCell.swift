//
//  BuyTbViewCell.swift
//  MeatWorks
//
//  Created by fwThanh on 10/8/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class BuyTbViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbUnit: UILabel!
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var lbVPrice: UILabel!
    @IBOutlet var lbCode: UILabel!
    @IBOutlet var widthImg: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        widthImg.constant = 60
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
