//
//  CreditCardTypeValidator.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

open class CreditCardValidator {
    open let supportedCardTypes: [CreditCardType]
    
    public init(_ supportedCardTypes: [CreditCardType]) {
        
        self.supportedCardTypes = supportedCardTypes
    }
}

// MARK: - Public Methods
public extension CreditCardValidator {
    
}

// MARK: - Luhn Check Algorithm
private extension CreditCardValidator {
    // per https://gist.github.com/cwagdev/635ce973e8e86da0403a
    func luhnCheck(_ cardNumber: String) -> Bool {
        var sum: Int = 0
        for (idx, element) in (cardNumber.reversed().map { String($0) }).enumerated() {
            guard let digit = Int(element) else {
                return false
            }
            
            switch ((idx % 2 == 1), digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
}
