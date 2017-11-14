//
//  Delivery.swift
//  MeatWorks
//
//  Created by fwThanh on 10/24/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Foundation

@objc(Delivery)
class Delivery: NSObject, NSCoding {
    
    var email   : String?
    var address    : String?
    var phone           : String?
    var dDescription           : String?
    var direction           : String?
    var fullname           : String?
    
    init(email : String, address : String, phone: String, dDescription: String, direction: String, fullname: String) {
        self.email          = email
        self.address        = address
        self.phone          = phone
        self.dDescription    = dDescription
        self.direction      = direction
        self.fullname       = fullname
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.address = aDecoder.decodeObject(forKey: "address") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
        self.dDescription = aDecoder.decodeObject(forKey: "dDescription") as? String
        self.direction = aDecoder.decodeObject(forKey: "direction") as? String
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(dDescription, forKey: "dDescription")
        aCoder.encode(direction, forKey: "direction")
        aCoder.encode(fullname, forKey: "fullname")
    }
    
}
