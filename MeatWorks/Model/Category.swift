//
//  Category.swift
//
//  Created by Huy Nguyen on 10/7/17.
//  Copyright © 2017 Poeta. All rights reserved.
//

import Foundation

class Category: NSObject {
    
    var type_id: String
    var type_name: String
    var product_id: String
    var product_name: String
    var photo: String
    
    init(type_id : String, type_name : String, product_id: String, product_name: String, photo: String) {
        self.type_id   = type_id
        self.type_name   = type_name
        self.product_id   = product_id
        self.product_name   = product_name
        self.photo   = photo
    }
    
    convenience init(keys: [String]?, values: [String]?) {
        self.init(type_id: "", type_name: "", product_id: "", product_name: "", photo: "")
        
        guard let keyArr = keys else {return}
        guard let valueArr = values else {return}
        
        for (index, key) in keyArr.enumerated() {
            
            if key == "type_id" {
                self.type_id = valueArr[index]
            }
            
            if key == "type_name" {
                self.type_name = valueArr[index]
            }
            
            if key == "product_id" {
                self.product_id = valueArr[index]
            }
            
            if key == "product_name" {
                self.product_name = valueArr[index]
            }
            
            if key == "photo" {
                self.photo = valueArr[index]
            }
        }
    }
}
