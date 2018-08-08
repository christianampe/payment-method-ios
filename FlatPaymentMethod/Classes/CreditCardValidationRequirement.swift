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

public extension CreditCardValidationRequirement {
    func isValid(_ accountNumber: String) -> Bool {
        return isLengthValid(accountNumber) && isPrefixValid(accountNumber)
    }
    
    func isPrefixValid(_ accountNumber: String) -> Bool {
        guard prefixes.count > 0 else {
            return true
        }
        
        return prefixes.contains { $0.hasCommonPrefix(with: accountNumber) }
    }
}

private extension CreditCardValidationRequirement {
    func isLengthValid(_ accountNumber: String) -> Bool {
        guard lengths.count > 0 else {
            return true
            
        }
        
        return lengths.contains { accountNumber.count == $0 }
    }
}
