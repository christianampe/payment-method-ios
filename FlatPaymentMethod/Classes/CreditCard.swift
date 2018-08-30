//
//  CreditCard.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/28/18.
//

import FlatCreditCard

public extension CreditCard {
    public convenience init() {
        self.init(number: "",
                  cvv: "",
                  expiration: "",
                  name: "",
                  logo: nil)
    }
}

public extension CreditCard {
    public static let empty = CreditCard()
}
