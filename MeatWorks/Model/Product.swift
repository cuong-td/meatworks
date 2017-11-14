//
//  Category.swift
//
//  Created by Huy Nguyen on 10/7/17.
//  Copyright © 2017 Poeta. All rights reserved.
//

import Foundation

class Product: NSObject {
    
    var product_name: String?
    var product_name_lg: String?
    var product_code: String?
    var unit_price: String?
    var product_id: String?
    var photo: String?
    var currency_id: String?
    var unit_name: String?
    var unit_id: String?
    var parent_id: String?
    
    convenience init(keys: [String]?, values: [String]?) {
        self.init()
        
        guard let keyArr = keys else {return}
        guard let valueArr = values else {return}
        
        for (index, key) in keyArr.enumerated() {
            
            if key == "product_name" {
                self.product_name = valueArr[index]
            }
            
            if key == "product_name_lg" {
                self.product_name_lg = valueArr[index]
            }
            
            if key == "product_code" {
                self.product_code = valueArr[index]
            }
            
            if key == "unit_price" {
                self.unit_price = valueArr[index]
            }
            
            if key == "product_id" {
                self.product_id = valueArr[index]
            }
            
            if key == "photo" {
                self.photo = valueArr[index]
            }
            
            if key == "currency_id" {
                self.currency_id = valueArr[index]
            }
            
            if key == "unit_name" {
                self.unit_name = valueArr[index]
            }
            
            if key == "unit_id" {
                self.unit_id = valueArr[index]
            }
            
            if key == "parent_id" {
                self.parent_id = valueArr[index]
            }
            
        }
    }
}
