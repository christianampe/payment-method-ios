//
//  CreditCardViewDataSource.swift
//  FlatPaymentMethod_Example
//
//  Created by Ampe on 8/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import PaymentValidator

public protocol CreditCardViewDataSource {
    var number: Int { get set }
    var cvv: Int { get set }
    var expiration: Date { get set }
    var name: String { get set }
    
    func style(for cardType: CreditCardType) -> CreditCardStyle
}

// MARK: - Default Implementations
public extension CreditCardViewDataSource {
    func style(for cardType: CreditCardType) -> CreditCardStyle {
        return cardType.style
    }
}
