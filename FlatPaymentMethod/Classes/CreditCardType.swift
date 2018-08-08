//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public enum CreditCardType: Equatable {
    case amex
    case unionPay
    case dinersClub(type: DinersClubType)
    case discover
    case jcb
    case maestro
    case dankort
    case masterCard
    case visa(type: VisaType)
}

public enum DinersClubType: Equatable {
    case carteBlanche
    case international
    case usbc
}

public enum VisaType: Equatable {
    case visa
    case electron
}
