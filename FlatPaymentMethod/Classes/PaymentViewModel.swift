//
//  PaymentViewModelViewModel.swift
//  FlatCreditCard
//
//  Created by Ampe on 8/17/18.
//

import FlatCreditCard
import PaymentValidator

public class PaymentViewModel: CreditCardViewModel {
    
    // MARK: Stored Constants
    public let creditCard: CreditCard
    public let validator: CreditCardTypeValidator
    public let numberSecurity: CardNumberSecurityStyle
    public let cvvSecurity: CardCVVSecurityStyle
    
    // MARK: Stored Variables
    public var delegate: CreditCardViewModelDelegate
    
    // MARK: Custom Initalizer
    public init(_ creditCard: CreditCard = .empty,
                delegate: CreditCardViewModelDelegate,
                supportedCards: [CreditCardType] = CreditCardType.all,
                numberSecurity: CardNumberSecurityStyle = .off,
                cvvSecurity: CardCVVSecurityStyle = .off) {
        
        self.creditCard = creditCard
        self.delegate = delegate
        self.validator = CreditCardTypeValidator(supportedCards)
        self.numberSecurity = numberSecurity
        self.cvvSecurity = cvvSecurity
    }
}

public extension PaymentViewModel {
    public func number(for card: CreditCard) -> String {
        guard !card.metadata.number.isEmpty else {
            updateLogo(to: nil)
            updateStyle(to: .default)
            return card.metadata.number
        }
        
        let state = validator.state(prefix: card.metadata.number)
        
        switch state {
        case .identified(let card):
            updateLogo(to: card.logoDark)
            updateStyle(to: card.identifiedStyle)
        case .indeterminate(let cards):
            updateLogo(to: cards.first?.logoDark)
            
            if let firstCard = cards.first {
                updateStyle(to: firstCard.indeterminateStyle)
            }
        case .unsupported(let cards):
            if let firstCard = cards.first {
                updateStyle(to: firstCard.unsupportedStyle)
            }
        case .invalid:
            updateStyle(to: .defaultInvalidStyle)
        }
        
        return formatted(for: state, number: card.metadata.number)
    }
    
    public func cvv(for card: CreditCard) -> String {
        return cvvSecurity.secureText(for: card.metadata.cvv)
    }
}

extension PaymentViewModel {
    func formatted(for state: CreditCardTypeValidationState, number: String) -> String {
        let secureText = numberSecurity.secureText(for: number)
        
        var numberGrouping: CreditCardViewNumberGroupingStyle = .none
        
        if let grouping = state.segmentGrouping(for: number.count) {
            numberGrouping = .custom(grouping: grouping, separator: .space, addRemainderSection: false)
        }
        
        return numberGrouping.groupedText(for: secureText)
    }
}
