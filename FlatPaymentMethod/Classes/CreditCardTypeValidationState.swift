//
//  CreditCardTypeValidationState.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public enum CreditCardTypeValidationState: Equatable {
    case identified(CreditCardType)
    case indeterminate(cards: [CreditCardType])
    case unsupported(cards: [CreditCardType])
    case invalid
}

public extension CreditCardTypeValidationState {
    // MARK: Explicit Initalizer
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
    
    // MARK: Prefix Initalizer
    init(fromPrefix prefix: String, supportedCards: [CreditCardType]) {
        
        // ensure that there are cards that can be supported
        guard supportedCards.count > 0 else {
            self = .invalid
            return
        }
        
        //
        let validCardTypes = CreditCardType.all.validate(prefix: prefix)
        
        guard validCardTypes.count > 0 else {
            self = .invalid
            return
        }
        
        let possibleSet: Set<CreditCardType> = Set(validCardTypes)
        let supportedSet: Set<CreditCardType> = Set(supportedCards)
        
        guard supportedSet.intersection(possibleSet).count > 0 else {
            self = .unsupported(cards: validCardTypes)
            return
        }
        
        if validCardTypes.count == 1 {
            guard let card = validCardTypes.first else {
                assert(false, "internal inconsistency - file a bug")
                self = .invalid
                return
            }
            
            self = .identified(card)
        } else {
            self = .indeterminate(cards: validCardTypes)
        }
    }
}

public extension CreditCardTypeValidationState {
    var cards: [CreditCardType]? {
        switch self {
        case .identified(let identifiedCard):
            return [identifiedCard]
        case .indeterminate(let identifiedCards):
            return identifiedCards
        default:
            return nil
        }
    }
}

public extension CreditCardTypeValidationState {
    func segmentGrouping(for length: Int) -> [Int]? {
        switch self {
        case .identified(let card):
            return card.segmentGrouping(for: length)
        case .indeterminate:
            return Mathematics.defaultGrouping(for: length)
        case .unsupported(let cards):
            if cards.count == 1, let card = cards.first {
                return card.segmentGrouping(for: length)
            } else {
                return Mathematics.defaultGrouping(for: length)
            }
        case .invalid:
            return nil
        }
    }
}
