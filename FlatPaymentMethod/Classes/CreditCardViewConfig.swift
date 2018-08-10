//
//  CreditCardViewConfig.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/10/18.
//

import Foundation

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

public enum CardNumberSecurityStyle {
    case on
    case show(last: Int)
    case off
}

public enum CardCVVSecurityStyle {
    case on
    case off
}
