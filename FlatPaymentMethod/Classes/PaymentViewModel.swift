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
    public init(_ creditCard: CreditCard = .default,
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
        guard !card.number.isEmpty else {
            updateLogo(to: nil)
            return card.number
        }
        
        switch validator.card(for: card.number) {
        case .identified(let card):
            updateLogo(to: card.logoDark)
        case .indeterminate(let cards):
            updateLogo(to: cards.first?.logoDark)
        case .unsupported:
            break
        case .invalid:
            break
        }
        
        return numberSecurity.secureText(for: card.number)
    }
    
    public func cvv(for card: CreditCard) -> String {
        return cvvSecurity.secureText(for: card.cvv)
    }
}
