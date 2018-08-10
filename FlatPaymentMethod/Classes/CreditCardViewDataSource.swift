//
//  CreditCardViewDataSource.swift
//  FlatPaymentMethod_Example
//
//  Created by Ampe on 8/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import PaymentValidator

public protocol CreditCardViewDataSource {
    var number: Int { get set }
    var cvv: Int { get set }
    var expiration: Date { get set }
    var name: String { get set }
    
    func logo(for cardType: CreditCardType) -> UIImage
    func segmentGrouping(for cardType: CreditCardType, with length: Int) -> [Int]
    
}
