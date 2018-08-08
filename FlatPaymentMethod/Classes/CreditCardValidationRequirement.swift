//
//  CreditCardValidationRequirement.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public struct CreditCardValidationRequirement {
    public let prefixes: [PrefixContainable]
    public let lengths: [Int]
}
