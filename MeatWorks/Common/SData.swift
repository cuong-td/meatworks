//
//  SData.swift
//  MeatWorks
//
//  Created by fwThanh on 10/7/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class SData: NSObject {
    
    static let shared = SData()
    
    var listNewProducts: [Product]?
    var listCategories = [String: [Category]]()
    var listProducts = [Product]()
    var current_posId: String?
    var current_saleId: String?
    var listDetailId = [String?]()
    var listCartItems: [Cart]?
}

