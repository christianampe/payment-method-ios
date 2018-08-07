//
//  CreditCardTypeValidator.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

open class CreditCardValidator {
    
    // per https://baymard.com/checkout-usability/credit-card-patterns
    // Feb 3, 2017 article publish date
    // Aug 7, 2018 implementation date
    // Aug 7, 2018 implementation updated date
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
            prefixes = ["500000"..."509999", "560000"..."589999", "600000"..."699999"]
            lengths = [12, 13, 14, 15, 16, 17, 18, 19]
        case .dankort:
            prefixes = ["5019"]
            lengths = [16]
        case .masterCard:
            prefixes = ["51"..."55"]
            lengths = [16]
        case .visa(let type):
            switch type {
            case .visa:
                prefixes = ["4"]
                lengths = [13, 14, 15, 16, 17, 18, 19]
            case .electron:
                prefixes = ["4026", "417500", "4405", "4508", "4844", "4913", "4917"]
                lengths = [16]
            }
        }
        
        return CreditCardValidationRequirement(prefixes: prefixes, lengths: lengths)
    }
}
