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
    
    var id          : String?
    var district    : String?
    
    init(id : String, district : String) {
        self.id   = id
        self.district   = district
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.district = aDecoder.decodeObject(forKey: "district") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(district, forKey: "district")
    }
    
}
