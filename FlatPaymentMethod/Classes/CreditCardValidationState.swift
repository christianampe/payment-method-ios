//
//  CreditCardValidationState.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public enum CreditCardValidationState: Equatable {    
    case determined(card: CreditCardType)
    case indeterminate(cards: [CreditCardType])
    case invalid
}
