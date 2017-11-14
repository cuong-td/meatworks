//
//  GroupUnit.swift
//  Locker44
//
//  Created by Huy Nguyen on 10/8/17.
//  Copyright © 2017 Poeta. All rights reserved.
//

import Foundation

class GroupUnit: NSObject {
    
    var parent_id: String?
    var group_name: String?
    var unit_id: String?
    var unit_name: String?
    var factor: String?
    
    convenience init(keys: [String]?, values: [String]?) {
        self.init()
        
        guard let keyArr = keys else {return}
        guard let valueArr = values else {return}
        
        for (index, key) in keyArr.enumerated() {
            
            if key == "parent_id" {
                self.parent_id = valueArr[index]
            }
            
            if key == "group_name" {
                self.group_name = valueArr[index]
            }
            
            if key == "unit_id" {
                self.unit_id = valueArr[index]
            }
            
            if key == "unit_name" {
                self.unit_name = valueArr[index]
            }
            
            if key == "factor" {
                self.factor = valueArr[index]
            }
        }
    }
}
