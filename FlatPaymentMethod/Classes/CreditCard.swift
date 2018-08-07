//
//  CreditCard.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public struct CreditCard {
    public let number: Int
    public let cvc: Int
    public let expiration: Date
    public let name: String
}
