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

public extension CreditCardValidator {
    
}

// MARK: - Luhn Check Algorithm
private extension CreditCardValidator {
    // per https://gist.github.com/cwagdev/635ce973e8e86da0403a
    func luhnCheck(_ cardNumber: String) -> Bool {
        var sum = 0
        let reversedCharacters = cardNumber.reversed().map { String($0) }
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
}
