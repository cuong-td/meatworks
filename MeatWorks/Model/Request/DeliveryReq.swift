//
//  DeliveryRequest.swift
//  MeatWorks
//
//  Created by Cuong Thai on 6/4/21.
//  Copyright © 2021 Bzb. All rights reserved.
//

import Foundation

public struct DeliveryRequest: Codable {
    public var saleId: String = ""
    public let phone: String
    public let fullname: String
    public let email: String
    public let direction: String
    public let address: String
    public let deliveryDescription: String?
                    
    public init(phone: String,
                fullname: String,
                email: String,
                direction: String,
                address: String,
                deliveryDescription: String?) {
        self.phone = phone
        self.fullname = fullname
        self.email = email
        self.direction = direction
        self.address = address
        self.deliveryDescription = deliveryDescription
    }
    
    enum CodingKeys: String, CodingKey {
        case saleId
        case phone
        case fullname
        case email
        case direction
        case address
        case deliveryDescription
    }
    
    static func create(_ from: Delivery) -> DeliveryRequest {
        return DeliveryRequest(phone: from.phone ?? "",
                               fullname: from.fullname ?? "",
                               email: from.email ?? "",
                               direction: from.direction ?? "",
                               address: from.address ?? "",
                               deliveryDescription: from.description)
    }
}
