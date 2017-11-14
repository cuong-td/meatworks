//
//  Country.swift
//  Folotrail
//
//  Created by fwThanh on 9/24/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Foundation

@objc(Country)
class Country: NSObject, NSCoding {
    
    var pos_id      : String?
    var pos_code    : String?
    var pos_name    : String?
    var tel         : String?
    var logo        : String?
    
    init(pos_id : String, pos_code : String, pos_name: String, tel: String, logo: String) {
        self.pos_id   = pos_id
        self.pos_code   = pos_code
        self.pos_name   = pos_name
        self.tel   = tel
        self.logo   = logo
    }
    
    convenience init(keys: [String]?, values: [String]?) {
        self.init(pos_id: "", pos_code: "", pos_name: "", tel: "", logo: "")
        
        guard let keyArr = keys else {return}
        guard let valueArr = values else {return}
        
        for (index, key) in keyArr.enumerated() {
            
            if key == "pos_id" {
                self.pos_id = valueArr[index]
            }
            
            if key == "pos_code" {
                self.pos_code = valueArr[index]
            }
            
            if key == "pos_name" {
                self.pos_name = valueArr[index]
            }
            
            if key == "tel" {
                self.tel = valueArr[index]
            }
            
            if key == "logo" {
                self.logo = valueArr[index]
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pos_id = aDecoder.decodeObject(forKey: "pos_id") as? String
        self.pos_code = aDecoder.decodeObject(forKey: "pos_code") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(pos_id, forKey: "pos_id")
        aCoder.encode(pos_code, forKey: "pos_code")
    }
    
}
