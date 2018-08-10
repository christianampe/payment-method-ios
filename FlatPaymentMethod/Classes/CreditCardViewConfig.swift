//
//  CreditCardViewConfig.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/10/18.
//

import Foundation
import PaymentValidator

public struct CreditCardViewConfig {
    public let backgroundColor: UIColor
    public let borderWidth: CGFloat
    public let borderColor: UIColor
    public let textColor: UIColor
    public let logo: UIImage
    public let numberGrouping: [Int]
    public let numberSecurity: CardNumberSecurityStyle
    public let cvvLength: Int
    public let cvvSecurity: CardCVVSecurityStyle
}

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

public enum CardNumberSecurityStyle {
    case on
    case show(last: Int)
    case off
}

public enum CardCVVSecurityStyle {
    case on
    case off
}
