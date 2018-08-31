//
//  CreditCardViewStyle.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/30/18.
//

import FlatCreditCard

public extension CreditCardViewStyle {
    static let defaultIdentifiedStyle: CreditCardViewStyle = .clear(borderWidth: 1, borderColor: .darkGray)
    static let defaultIndeterminateStyle: CreditCardViewStyle = .clear(borderWidth: 1, borderColor: .lightGray)
    static let defaultUnsupportedStyle: CreditCardViewStyle = .clear(borderWidth: 1, borderColor: .blue)
    static let defaultInvalidStyle: CreditCardViewStyle = .clear(borderWidth: 1, borderColor: .red)
}
