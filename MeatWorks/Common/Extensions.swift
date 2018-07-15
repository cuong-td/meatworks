//
//  Extensions.swift
//  MeatWorks
//
//  Created by Cuong Thai on 7/14/18.
//  Copyright © 2018 Bzb. All rights reserved.
//

import Foundation

extension String {
    func getBase64() -> String {
        if let data = self.data(using: String.Encoding.utf8) {
            return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        return ""
    }
    func format(parameters: CVarArg...) -> String {
        return String(format: self, arguments: parameters)
    }
    func numFormat() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        let num = formatter.number(from: self)
        if (num != nil) {
            return formatter.string(from: num!) ?? self
        }
        return self
    }
}

extension Double {
    func formatAsCurrency(currencyCode: String) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .decimal
//        currencyFormatter.currencyCode = currencyCode
//        currencyFormatter.locale = (currencyCode == "VND" ? Locale(identifier: "vi") : Locale(identifier: "en"))
//        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
//        let locale = NSLocale(localeIdentifier: currencyCode)
//        let currencySymbol = locale.displayName(forKey: .currencySymbol, value: currencyCode) ?? currencyCode
        return (currencyFormatter.string(from: NSNumber(value: self)) ?? "") + currencyCode
    }
}
