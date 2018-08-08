//
//  CreditCardType.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

// MARK: - Credit Card Types
public enum CreditCardType: Equatable, Hashable {
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

// MARK: - All Cards
public extension CreditCardType {
    public static let all: [CreditCardType] = [.visa(type: .visa),
                                               .visa(type: .electron),
                                               .amex, .unionPay,
                                               .masterCard,
                                               .maestro,
                                               .dinersClub(type: .carteBlanche),
                                               .dinersClub(type: .international),
                                               .dinersClub(type: .usbc),
                                               .discover, .jcb,
                                               .uatp, .dankort,
                                               .interPayment]
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

public extension CreditCardType {
    func isValid(_ accountNumber: String) -> Bool {
        return requirement.isValid(accountNumber) && luhnCheck(accountNumber)
    }
    
    func isPrefixValid(_ accountNumber: String) -> Bool {
        return requirement.isPrefixValid(accountNumber)
    }
}

public extension CreditCardType {
    static let defaultSegmentSize: Int = 4
    
    func segmentGrouping(for length: Int) -> [Int] {
        if let assignedGrouping = segmentGrouping[length] {
            return assignedGrouping
        } else {
            return defaultGrouping(for: length)
        }
    }
    
    func defaultGrouping(for length: Int) -> [Int] {
        var defaultGrouping: [Int]
        
        let fullSegments: Int = Int(Double(length / CreditCardType.defaultSegmentSize).rounded(.down))
        let remainder: Int = length % CreditCardType.defaultSegmentSize
        
        let fullSegmentArray: [Int] = Array(repeating: CreditCardType.defaultSegmentSize, count: fullSegments)
        
        defaultGrouping = fullSegmentArray
        
        if remainder > 0 {
            guard remainder < CreditCardType.defaultSegmentSize else {
                assert(false, "internal inconsistency - file a bug")
                return defaultGrouping
            }
            
            defaultGrouping.append(remainder)
        }
        
        return defaultGrouping
    }
}

// MARK: - Luhn Check Algorithm
private extension CreditCardType {
    // per https://gist.github.com/cwagdev/635ce973e8e86da0403a
    func luhnCheck(_ cardNumber: String) -> Bool {
        var sum: Int = 0
        for (idx, element) in (cardNumber.reversed().map { String($0) }).enumerated() {
            guard let digit = Int(element) else {
                return false
            }
            
            switch ((idx % 2 == 1), digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
}


// MARK: - Constants For Determining Card Type
private extension CreditCardType {
    // per https://baymard.com/checkout-usability/credit-card-patterns
    // Feb 3, 2017 article publish date
    // Aug 7, 2018 implementation date
    // Aug 7, 2018 implementation updated date
    var requirement: CreditCardTypeValidationRequirement {
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
        
        return CreditCardTypeValidationRequirement(prefixes: prefixes, lengths: lengths)
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
