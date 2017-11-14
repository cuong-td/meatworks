//
//  User.swift
//  Folotrail
//
//  Created by Phan Quoc Thanh on 9/1/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Foundation

@objc(User)
class User: NSObject, NSCoding {
    
    var currentUserId   : String?
    var currentEmail    : String?
    var token           : String?
    
    init(userId : String, email : String, token: String) {
        self.currentUserId  = userId
        self.currentEmail   = email
        self.token          = token
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.currentUserId = aDecoder.decodeObject(forKey: "userId") as? String
        self.currentEmail = aDecoder.decodeObject(forKey: "currentEmail") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(currentUserId, forKey: "userId")
        aCoder.encode(currentEmail, forKey: "currentEmail")
        aCoder.encode(token, forKey: "token")
    }
    
}

