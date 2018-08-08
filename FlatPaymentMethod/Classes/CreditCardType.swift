//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

// MARK: - Credit Card Types
public enum CreditCardType: Equatable {
    case visa(type: VisaType)
    case amex
    case unionPay
    case masterCard
    case maestro
    case dinersClub(type: DinersClubType)
    case discover
    case jcb
    case uatp
    case dankort
    case interPayment
}

// MARK: - Diners Card Types
public enum DinersClubType: Equatable {
    case carteBlanche
    case international
    case usbc
}

// MARK: - Visa Card Types
public enum VisaType: Equatable {
    case visa
    case electron
}

// MARK: - Constants For Determining Card Type
public extension CreditCardType {
    // per https://baymard.com/checkout-usability/credit-card-patterns
    // Feb 3, 2017 article publish date
    // Aug 7, 2018 implementation date
    // Aug 7, 2018 implementation updated date
    var requirements: CreditCardValidationRequirement {
        let prefixes: [PrefixContainable]
        let lengths: [Int]
        
        switch self {
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
        case .uatp:
            prefixes = ["1"]
            lengths = [15]
        case .interPayment:
            prefixes = ["4026", "417500", "4405", "4508", "4844", "4913", "4917"]
            lengths = [16]
        }
        
        return CreditCardValidationRequirement(prefixes: prefixes, lengths: lengths)
    }
    
    // per https://baymard.com/checkout-usability/credit-card-patterns
    // Feb 3, 2017 article publish date
    // Aug 7, 2018 implementation date
    // Aug 7, 2018 implementation updated date
    var segmentGrouping: [Int: [Int]] {
        switch self {
        case .amex:
            return [16: [4, 6, 5]]
        case .unionPay:
            return [16: [4, 4, 4, 4],
                    19: [6, 13]]
        case .dinersClub(let type):
            switch type {
            case .carteBlanche:
                return [14: [4, 6, 4]]
            case .international:
                return [14: [4, 6, 4]]
            case .usbc:
                return [16: [4, 4, 4, 4]]
            }
        case .discover:
            return [16: [4, 4, 4, 4]]
        case .jcb:
            return [16: [4, 4, 4, 4]]
        case .maestro:
            return [13: [4, 4, 5],
                    15: [4, 6, 5],
                    16: [4, 4, 4, 4],
                    19: [4, 4, 4, 4, 3]]
        case .dankort:
            return [16: [4, 4, 4, 4]]
        case .masterCard:
            return [16: [4, 4, 4, 4]]
        case .visa(let type):
            switch type {
            case .visa:
                return [16: [4, 4, 4, 4]]
            case .electron:
                return [16: [4, 4, 4, 4]]
            }
        case .uatp:
            return [15: [4, 5, 6]]
        case .interPayment:
            return [16: [4, 4, 4, 4]]
        }
    }
    
    // per scraping the internet
    // Aug 7, 2018 implementation date
    // Aug 7, 2018 implementation updated date
    var cvvLength: Int {
        switch self {
        case .amex:
            return 4
        default:
            return 3
        }
    }
}
