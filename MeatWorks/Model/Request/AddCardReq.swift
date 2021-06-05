//
//  AddCardReq.swift
//  MeatWorks
//
//  Created by Cuong Thai on 6/4/21.
//  Copyright © 2021 Bzb. All rights reserved.
//

import Foundation

public struct AddCardRequest: Codable {
    public var saleId: String = ""
    public let posId: String
    public let productId: String
    public let quantity: Int
    public let unitId: String
    public let unitPrice: Double
    public let cartDescription: String?
                    
    public init(posId: String,
                productId: String,
                quantity: Int,
                unitId: String,
                unitPrice: Double,
                cartDescription: String?) {
        self.posId = posId
        self.productId = productId
        self.quantity = quantity
        self.unitId = unitId
        self.unitPrice = unitPrice
        self.cartDescription = cartDescription
    }
    
    enum CodingKeys: String, CodingKey {
        case saleId
        case posId
        case productId
        case quantity
        case unitId
        case unitPrice
        case cartDescription
    }
}
