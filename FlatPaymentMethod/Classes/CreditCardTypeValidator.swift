//
//  CreditCardTypeValidator.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

open class CreditCardValidator {
    open let supportedCardTypes: [CreditCardType]
    
    public init(_ supportedCardTypes: [CreditCardType] = CreditCardType.all) {
        
        self.supportedCardTypes = supportedCardTypes
    }
}

// MARK: - Public Methods
public extension CreditCardValidator {
    func card(for accountNumber: String) -> CreditCardValidationState {
        return CreditCardValidationState(fromNumber: accountNumber, supportedCards: supportedCardTypes)
    }
}
