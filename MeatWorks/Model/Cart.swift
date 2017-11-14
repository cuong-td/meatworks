//
//  Cart.swift
//  MeatWorks
//
//  Created by fwThanh on 10/24/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Foundation

class Cart: NSObject {
    
    var product_name: String?
    var input_quantity: String?
    var quantity: String?
    var unit_price: String?
    var currency_id: String?
    var sale_detail_id: String?
    var photo: String?
    var product_id: String?
    var product_code: String?
    var unit_name: String?
    
    convenience init(keys: [String]?, values: [String]?) {
        self.init()
        
        guard let keyArr = keys else {return}
        guard let valueArr = values else {return}
        
        for (index, key) in keyArr.enumerated() {
            
            if key == "product_code" {
                self.product_code = valueArr[index]
            }
            
            if key == "product_name" {
                self.product_name = valueArr[index]
            }
            
            if key == "input_quantity" {
                self.input_quantity = valueArr[index]
            }
            
            if key == "quantity" {
                self.quantity = valueArr[index]
            }
            
            if key == "unit_price" {
                self.unit_price = valueArr[index]
            }
            
            if key == "currency_id" {
                self.currency_id = valueArr[index]
            }
            
            if key == "sale_detail_id" {
                self.sale_detail_id = valueArr[index]
            }
            
            if key == "photo" {
                self.photo = valueArr[index]
            }
            
            if key == "product_id" {
                self.product_id = valueArr[index]
            }
            
            if key == "unit_name" {
                self.unit_name = valueArr[index]
            }

        }
    }
}
