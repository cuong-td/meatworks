//
//  Food.swift
//  Locker44
//
//  Created by Huy Nguyen on 10/6/17.
//  Copyright © 2017 Poeta. All rights reserved.
//

import Foundation

class Food: NSObject {
    
    var product_name: String?
    var product_name_lg: String?
    var parent_id: String?
    var product_id: String?
    var order_by: String?
    var photo: String?
    
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
            
            if key == "parent_id" {
                self.parent_id = valueArr[index]
            }
            
            if key == "product_id" {
                self.product_id = valueArr[index]
            }
            
            if key == "order_by" {
                self.order_by = valueArr[index]
            }
            
            if key == "photo" {
                self.photo = valueArr[index]
            }
        }
    }
    
}
