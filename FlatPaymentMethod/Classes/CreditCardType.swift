//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/29/18.
//

import PaymentValidator
import FlatCreditCard

public extension CreditCardType {
    var identifiedStyle: CreditCardViewStyle {
        switch self {
        case .visa:
            return .fill(backgroundColor: .lightGray)
        case .mastercard:
            return .fill(backgroundColor: .darkGray)
        default:
            return .defaultIdentifiedStyle
        }
    }
    
    var indeterminateStyle: CreditCardViewStyle {
        switch self {
        default:
            return .defaultIndeterminateStyle
        }
    }
    
    var unsupportedStyle: CreditCardViewStyle {
        switch self {
        default:
            return .defaultUnsupportedStyle
        }
    }
}
