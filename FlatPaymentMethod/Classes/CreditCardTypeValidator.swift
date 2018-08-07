//
//  CreditCardTypeValidator.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

open class CreditCardValidator {
    func requirements(for cardType: CreditCardType) -> CreditCardValidationRequirement? {
        let prefixes: [PrefixContainable]
        let lengths: [Int]
        
        switch cardType {
        case .amex:
            prefixes = ["34", "37"]
            lengths = [15]
        case .unionPay:
            prefixes = ["62"]
            lengths = [16, 17, 18, 19]
        case .dinersClub(let type):
            switch type {
            case .carteBlanche:
                prefixes = ["300"..."305"]
                lengths = [14]
            case .international:
                prefixes = ["309", "36", "38"..."39"]
                lengths = [14]
            case .usbc:
                prefixes = ["54"..."55"]
                lengths = [16]
            }
        case .discover:
            prefixes = ["6011", "622126"..."622925", "644"..."649", "65"]
            lengths = [16]
        case .jcb:
            prefixes = ["3528"..."3589"]
            lengths = [16]
        case .maestro:
            prefixes = []
            lengths = []
        case .dankort:
            prefixes = []
            lengths = []
        case .masterCard:
            prefixes = []
            lengths = []
        case .visa(let type):
            switch type {
            case .visa:
                prefixes = []
                lengths = []
            case .electron:
                prefixes = []
                lengths = []
            }
        }
        
        return CreditCardValidationRequirement(prefixes: prefixes, lengths: lengths)
    }
}
