//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/29/18.
//

import PaymentValidator
import FlatCreditCard

public extension CreditCardType {
    var style: CreditCardViewStyle {
        switch self {
        case .visa:
            return .fill(backgroundColor: .lightGray)
        case .mastercard:
            return .fill(backgroundColor: .darkGray)
        default:
            return .clear(borderWidth: 1, borderColor: .darkGray)
        }
    }
}
