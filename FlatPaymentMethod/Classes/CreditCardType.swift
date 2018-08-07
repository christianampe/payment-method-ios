//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

public enum CreditCardType {
    case amex
    case unionPay
    case dinersClub(type: DinersClubType)
    case discover
    case jcb
    case laser
    case maestro
    case dankort
    case masterCard
    case visa(type: VisaType)
}

public enum DinersClubType {
    case carteBlanche
    case international
    case usbc
}

public enum VisaType {
    case visa
    case electron
}
