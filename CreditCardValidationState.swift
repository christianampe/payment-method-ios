//
//  CreditCardValidationState.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public enum CreditCardValidationState: Equatable {
    case identified(CreditCardType)
    case indeterminate(cards: [CreditCardType])
    case unsupported(cards: [CreditCardType])
    case invalid
}

public extension CreditCardValidationState {
    init(fromNumber number: String, supportedCards: [CreditCardType]) {
        guard let card = CreditCardType.all.first(where: { $0.isValid(number) }) else {
            self = .invalid
            return
        }
        
        guard supportedCards.contains(card) else {
            self = .unsupported(cards: [card])
            return
        }
        
        self = .identified(card)
    }
    
    init(fromPrefix prefix: String, supportedCards: [CreditCardType]) {
        let possibleCardTypes = CreditCardType.all.filter { $0.isPrefixValid(prefix) }
        
        guard possibleCardTypes.count > 0 else {
            self = .invalid
            return
        }
        
        let possibleSet: Set<CreditCardType> = Set(possibleCardTypes)
        let supportedSet: Set<CreditCardType> = Set(supportedCards)
        
        guard supportedSet.intersection(possibleSet).count > 0 else {
            self = .unsupported(cards: possibleCardTypes)
            return
        }
        
        if possibleCardTypes.count == 1 {
            guard let card = possibleCardTypes.first else {
                self = .invalid
                
                assert(false, "internal inconsistency - file a bug")
                return
            }
            
            self = .identified(card)
        } else {
            self = .indeterminate(cards: possibleCardTypes)
        }
    }
}
