//
//  ViewController.swift
//  FlatPaymentMethod
//
//  Created by christianampe on 08/06/2018.
//  Copyright (c) 2018 christianampe. All rights reserved.
//

import UIKit
import FlatCreditCard
import FlatPaymentMethod

class ViewController: UIViewController {
    @IBOutlet weak var creditCard: CreditCardView!
    @IBOutlet weak var textField: UITextField!
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = PaymentViewModel(.empty,
                                         delegate: creditCard,
                                         supportedCards: [.visa(type: .electron),
                                                  .visa(type: .visa),
                                                  .mastercard],
                                         numberSecurity: .show(last: 4,
                                                       secureCharacter: "•"))
        
        creditCard.setViewModel(viewModel)
    }
}

extension ViewController {
    @IBAction func valueChanged(_ sender: Any) {
        creditCard.number = textField.text ?? ""
    }
}
