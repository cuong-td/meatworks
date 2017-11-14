//
//  Folotrail.swift
//  Folotrail
//
//  Created by Phan Quoc Thanh on 9/1/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import Foundation
import CoreTelephony
import SwiftyUserDefaults

struct Meatworks {
    
    static var userInfo : User? {
        get {
            return ACUserDefault?[.curentUserInfo]
        }
        set {
            ACUserDefault?[.curentUserInfo] = newValue
        }
    }
    
    static var deliveryInfo : Delivery? {
        get {
            return ACUserDefault?[.deliveryInfo]
        }
        set {
            ACUserDefault?[.deliveryInfo] = newValue
        }
    }
    
    static var listCarts : [String]? {
        get {
            return ACUserDefault?[.listCarts]
        }
        set {
            ACUserDefault?[.listCarts] = newValue
        }
    }
}

extension DefaultsKeys {
    static let userToken        = DefaultsKey<String?>("userToken")
    static let deliveryInfo     = DefaultsKey<Delivery?>("deliveryInfo")
    static let curentUserInfo   = DefaultsKey<User?>("curentUserInfo")
    static let listCarts        = DefaultsKey<[String]?>("cartItems")
}

extension UserDefaults {
    subscript(key: DefaultsKey<User?>) -> User? {
        get {
            NSKeyedArchiver.setClassName("User", for: User.self)
            return unarchive(key)
        }
        set {
            NSKeyedUnarchiver.setClass(User.self, forClassName: "User")
            archive(key, newValue)
        }
    }
    subscript(key: DefaultsKey<Delivery?>) -> Delivery? {
        get {
            NSKeyedArchiver.setClassName("Delivery", for: Delivery.self)
            return unarchive(key)
        }
        set {
            NSKeyedUnarchiver.setClass(Delivery.self, forClassName: "Delivery")
            archive(key, newValue)
        }
    }
}

public let ACUserDefault = UserDefaults(suiteName: "Meatworks")



