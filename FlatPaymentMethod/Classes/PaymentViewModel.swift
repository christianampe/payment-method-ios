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
            delegate.styleUpdated(to: .default)
            return card.metadata.number
        }
        
        switch validator.card(for: card.metadata.number) {
        case .identified(let card):
            updateLogo(to: card.logoDark)
            delegate.styleUpdated(to: card.identifiedStyle)
        case .indeterminate(let cards):
            updateLogo(to: cards.first?.logoDark)
            
            if let firstCard = cards.first {
                delegate.styleUpdated(to: firstCard.indeterminateStyle)
            }
        case .unsupported(let cards):
            if let firstCard = cards.first {
                delegate.styleUpdated(to: firstCard.unsupportedStyle)
            }
        case .invalid:
            delegate.styleUpdated(to: .defaultInvalidStyle)
        }
        
        return numberSecurity.secureText(for: card.metadata.number)
    }
    
    public func cvv(for card: CreditCard) -> String {
        return cvvSecurity.secureText(for: card.metadata.cvv)
    }
}

extension PaymentViewModel {
    func number(for cardState: CreditCardTypeValidationState) {
        switch cardState {
        case .identified(let card):
            
        case .indeterminate(let cards):
            
        case .unsupported(let cards):
            
        case .invalid:
            
        }
    }
}
