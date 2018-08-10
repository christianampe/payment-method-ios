//
//  CreditCardStyle.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/10/18.
//

import PaymentValidator

public enum CreditCardStyle {
    case fill(backgroundColor: UIColor)
    case clear(borderWidth: CGFloat, borderColor: UIColor)
}

public extension CreditCardStyle {
    var backgroundColor: UIColor {
        switch self {
        case .clear:
            return .clear
        case .fill(let backgroundColor):
            return backgroundColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .clear(let borderWidth, _):
            return borderWidth
        case .fill:
            return 0
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .clear(_, let borderColor):
            return borderColor
        case .fill:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .clear:
            return .black
        case .fill:
            return .white
        }
    }
    
    var numberSecurity: CardNumberSecurityStyle {
        return .default
    }
    
    var ccvSecurity: CardCVVSecurityStyle {
        return .default
    }
}

public extension CreditCardStyle {
    func logo(for cardType: CreditCardType) -> UIImage {
        switch self {
        case .clear:
            guard let colorLogo = UIImage(named: cardType.logoName) else {
                assert(false, "color logo for \(cardType.name) not found")
                return UIImage()
            }
            
            return colorLogo
        case .fill:
            guard let lightLogo = UIImage(named: "\(cardType.logoName)-light") else {
                assert(false, "light logo for \(cardType.name) not found")
                return UIImage()
            }
            
            return lightLogo
        }
    }
    
    func grouping(for cardType: CreditCardType, with length: Int) -> [Int] {
        return cardType.segmentGrouping(for: length)
    }
    
    func cvvLength(for cardType: CreditCardType) -> Int {
        return cardType.cvvLength
    }
}

private extension CreditCardType {
    var logoName: String {
        switch self {
        case .amex:
            return "amex"
        case .dankort:
            return "dankort"
        case .dinersClub:
            return "diners-club"
        case .discover:
            return "discover"
        case .interPayment:
            return "inter-payment"
        case .maestro:
            return "maestro"
        case .masterCard:
            return "mastercard"
        case .jcb:
            return "jcb"
        case .uatp:
            return "uatp"
        case .unionPay:
            return "union-pay"
        case .visa:
            return "visa"
        }
    }
}
