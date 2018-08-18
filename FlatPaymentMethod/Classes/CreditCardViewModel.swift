//
//  CreditCardViewModel.swift
//  FlatCreditCard
//
//  Created by Ampe on 8/17/18.
//

import FlatCreditCard
import PaymentValidator

public class CreditCardViewModel: FlatCreditCard.CreditCardViewModel {
    
    // MARK: Stored Constants
    public let creditCard: CreditCard
    public let validator: CreditCardTypeValidator
    public let numberSecurity: CardNumberSecurityStyle
    public let cvvSecurity: CardCVVSecurityStyle
    
    // MARK: Stored Variables
    public var delegate: CreditCardViewModelDelegate
    
    // MARK: Custom Initalizer
    public init(_ card: CreditCard,
                delegate: CreditCardViewModelDelegate,
                supportedCards: [CreditCardType] = CreditCardType.all,
                numberSecurity: CardNumberSecurityStyle = .off,
                cvvSecurity: CardCVVSecurityStyle = .off) {
        
        self.creditCard = card
        self.delegate = delegate
        self.validator = CreditCardTypeValidator(supportedCards)
        self.numberSecurity = numberSecurity
        self.cvvSecurity = cvvSecurity
    }
}
