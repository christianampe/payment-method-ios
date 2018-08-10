//
//  CreditCardViewDelegate.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public protocol CreditCardViewDelegate {
    func updatedNumber(_ newNumber: String)
    func updatedCVV(_ newCVV: String)
    func updatedExpiration(_ newExpiration: Date)
    func updateName(_ newName: String)
}
